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
#define ITERS       100

#define CHILD_CPU   0
#define CHILD_PRIO  0
#define PARENT_CPU  0
#define PARENT_PRIO 1

extern void set_prio (unsigned int, int);

static __inline__ unsigned long long
rdtsc (void)
{
  unsigned long long int x;
  __asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
  return x;
}

int
main(int argc, char **argv)
{
	int pipe_fd[2];
	pid_t child;
	unsigned long long w_total, w_start, w_end, r_total, r_start, r_end, r_worst = 0;
	char ch = 'a';

	if (pipe(pipe_fd) < 0) {
		perror("pipe");
		return -1;
	}

	child = fork();
	if (child > 0) {
		int i;

		set_prio(PARENT_PRIO, PARENT_CPU);
		assert(sched_getcpu() == PARENT_CPU);
		close(pipe_fd[0]);

		/* making sure read blocks for predictability */
		usleep(USEC_WAIT); 

		for (i = 0 ; i < ITERS ; i ++) {
			printf("W\n");
			if (write(pipe_fd[1], &ch, 1) < 0) {
				perror("write");
				/* TODO: kill child! */
				exit(-1);
			}
		}
		close(pipe_fd[1]);
		wait(NULL);
		exit(0);
	} else if (child == 0) {
		int i;

		set_prio(CHILD_PRIO, CHILD_CPU);
		assert(sched_getcpu() == CHILD_CPU);
		close(pipe_fd[1]);
		r_total = 0;

		for (i = 0 ; i < ITERS ; i ++) {
			r_start = rdtsc();
			printf("R\n");
			if (read(pipe_fd[0], &ch, 1) < 0) {
				perror("read");
				_exit(-1);
			}
			r_end = rdtsc();
			if ((r_end - r_start) > r_worst) r_worst = r_end - r_start;
			r_total += (r_end - r_start);
		}
		printf("read/write AVERAGE: %llu, WORST: %llu\n", (r_total)/(2 * ITERS), r_worst);

		close (pipe_fd[0]);
		_exit(0);
	} else {
		perror("fork");
	}

	close(pipe_fd[0]);
	close(pipe_fd[1]);

	return -1;
}
