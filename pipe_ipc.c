/*
 * Initial Clone from : https://github.com/phanikishoreg/scheduler-benchmarks
 */
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <assert.h>

#define USEC_WAIT   100
#define ITERS       1000000

#define CHILD_CPU   0
#define CHILD_PRIO  0
#define PARENT_CPU  0
#define PARENT_PRIO 1

#define CACHE_LINE_SIZE 64
#define WORKSET_SIZE_MIN CACHE_LINE_SIZE
#define WORKSET_SIZE_MAX (12*1024*1024)

#define WORKSET_32K 512 //L1 data
#define WORKSET_256K 4096 //L2
#define WORKSET_12MB 196608 //L3

#define WORKSET_TEST_SIZE WORKSET_12MB /* power of 2, upto 12MB */

#define CACHE_LINE_ULL_NELE (CACHE_LINE_SIZE/sizeof(unsigned long long))
struct workset_data {
	unsigned long long n; /* next array item to access */
} __attribute__((aligned(64)));

static struct workset_data ws[WORKSET_TEST_SIZE] __attribute__((aligned(4096)));

extern void set_prio (unsigned int, int);

static __inline__ unsigned long long
rdtsc (void)
{
  unsigned long long int x;
  __asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
  return x;
}

static inline void
generate_workset(void)
{

	int assigned[WORKSET_TEST_SIZE] = { 0 }, visited[WORKSET_TEST_SIZE] = { 0 };
	int i = 0, r = 0, c = 0, r0 = 0;

	assert(sizeof(struct workset_data) == CACHE_LINE_SIZE);

	if (WORKSET_TEST_SIZE == 1) {
		ws[0].n = 0;

		return;
	}


	r = random() % WORKSET_TEST_SIZE;
	visited[r] = 1;
	c = random() % WORKSET_TEST_SIZE;
	assigned[c] = 1;
	assert(r != c);
	ws[r].n = c;
	//printf("%d => %d,%d\n", i, r, c);
	i++;
	r0 = r;
	r = c;

	while (i < WORKSET_TEST_SIZE) {
		c = random() % WORKSET_TEST_SIZE;

		//printf("%d => %d,%d\n", i, r, c);
		assert(visited[r] == 0);
		if (visited[c] || assigned[c]) continue;

		visited[r] = 1;
		assigned[c] = 1;
		ws[r].n = c;
		r = c;

		i++;
		if (i == WORKSET_TEST_SIZE - 1) {
			ws[r].n = r0;
			break;
		}
	};

	//for (i = 0; i < WORKSET_TEST_SIZE; i++) printf("%llu\n", ws[i].n);
}

volatile unsigned long sum;

static void __attribute__((noinline))
access_workset(void)
{
	unsigned long long i = 0;
	int j = 0;
	unsigned long s = 0;

	i = ws[0].n;
	j++;

	while (j < WORKSET_TEST_SIZE) {
		i = ws[i].n;
		s += i;
		j++;
	}
	sum = s;
}

void
write_fn(int fd[]) 
{
	char ch = 'a';
	int i;

	for (i = 0 ; i < ITERS ; i ++) {
		access_workset();
		if (write(fd[1], &ch, 1) < 0) {
			perror("write");
			/* TODO: kill child! */
			exit(-1);
		}
	}
}

void
read_fn(int fd[])
{
	int i;
	char ch;
	unsigned long long r_total = 0, r_start, r_end, r_worst = 0;

	for (i = 0 ; i < ITERS ; i ++) {
		if (read(fd[0], &ch, 1) < 0) {
			perror("read");
			_exit(-1);
		}
		r_start = rdtsc();
		access_workset();
		r_end = rdtsc();
		if ((r_end - r_start) > r_worst) r_worst = r_end - r_start;
		r_total += (r_end - r_start);
	}
	printf("Passive Cost (Workset:%d, sz:%d) AVERAGE: %llu, WORST: %llu\n", WORKSET_TEST_SIZE, WORKSET_TEST_SIZE * CACHE_LINE_SIZE, (r_total)/(ITERS), r_worst);

#ifndef USE_FORK
	pthread_exit(NULL);
#endif
}


int
main(int argc, char **argv)
{
	int pipe_fd[2];
	pid_t child;
	pthread_t thd;

	printf("generate\n");
	generate_workset();
	printf("..done\n");
	printf("access\n");
	access_workset();
	printf("..done\n");

	if (pipe(pipe_fd) < 0) {
		perror("pipe");
		return -1;
	}

#ifdef USE_FORK
	printf("Using processes\n");
	child = fork();
	if (child > 0) {
		set_prio(PARENT_PRIO, PARENT_CPU);
		assert(sched_getcpu() == PARENT_CPU);
		close(pipe_fd[0]);

		/* making sure read blocks for predictability */
		usleep(USEC_WAIT); 

		write_fn(pipe_fd);
		close(pipe_fd[1]);
		wait(NULL);
		exit(0);
	} else if (child == 0) {
		int i;

		set_prio(CHILD_PRIO, CHILD_CPU);
		assert(sched_getcpu() == CHILD_CPU);
		close(pipe_fd[1]);

		read_fn(pipe_fd);


		close (pipe_fd[0]);
		_exit(0);
	} else {
		perror("fork");
	}
#else
	printf("Using threads\n");

	pthread_create(&thd, NULL, read_fn, pipe_fd);
	pthread_prio(thd, CHILD_PRIO);
	pthread_yield();
	set_prio(PARENT_PRIO, PARENT_CPU);
	
	write_fn(pipe_fd);
#endif

	close(pipe_fd[0]);
	close(pipe_fd[1]);

	return -1;
}
