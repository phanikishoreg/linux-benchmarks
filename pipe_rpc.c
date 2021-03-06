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

#define CHILD_CPU   1
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
	int pipe1_fd[2], pipe2_fd[2];
	pid_t child;
	unsigned long long total = 0, start, end, worst_case = 0;
	char ch = 'a';

	if (pipe(pipe1_fd) < 0) {
		perror("pipe");
		return -1;
	}

	if (pipe(pipe2_fd) < 0) {
		perror("pipe");
		return -1;
	}

	child = fork();
	if (child == 0) {
		int i, first = 1;

		set_prio(CHILD_PRIO, CHILD_CPU);
		assert(sched_getcpu() == CHILD_CPU);
		close(pipe1_fd[0]); /* only write here */
		close(pipe2_fd[1]); /* only read here */

		for (i = 0 ; i < ITERS ; i ++) {
			start = rdtsc();
			if (write(pipe1_fd[1], &ch, 1) <= 0) {
				perror("write");
				/* TODO: kill child! */
				_exit(-1);
			}
			if (read(pipe2_fd[0], &ch, 1) <= 0) {
				perror("read");
				/* TODO: kill child! */
				_exit(-1);
			}
			end = rdtsc();

			if (first) {
				first = 0;
				continue;
			}
			if ((end - start) > worst_case) worst_case = end - start;
			total += (end - start);

		}
		close(pipe1_fd[1]);
		close(pipe2_fd[0]);

		printf("rpc AVERAGE: %llu WORST: %llu\n", (total/(unsigned long long)(ITERS-1)), worst_case);
		_exit(0);
	} else if (child > 0) {
		int i;

		set_prio(PARENT_PRIO, PARENT_CPU);
		assert(sched_getcpu() == PARENT_CPU);
		close(pipe1_fd[1]); /* only read here */
		close(pipe2_fd[0]); /* only write here */

		for (i = 0 ; i < ITERS ; i ++) {
			if (read(pipe1_fd[0], &ch, 1) <= 0) {
				perror("read");
				exit(-1);
			}
			if (write(pipe2_fd[1], &ch, 1) <= 0) {
				perror("write");
				exit(-1);
			}
		}

		close (pipe1_fd[0]);
		close (pipe2_fd[1]);

		wait(NULL);
		exit(0);
	} else {
		perror("fork");
	}

	close(pipe1_fd[0]);
	close(pipe1_fd[1]);
	close(pipe2_fd[0]);
	close(pipe2_fd[1]);

	return -1;
}
