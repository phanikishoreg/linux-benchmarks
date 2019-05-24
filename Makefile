CC := gcc
RM := rm
CFLAGS := -O3 -g

all: pipe_ipc_proc pipe_ipc_thd

pipe_ipc_proc: pipe_ipc.c priority.c
	$(CC) $(CFLAGS) -DUSE_FORK pipe_ipc.c priority.c -o $@.out -lrt -lpthread

pipe_ipc_thd: pipe_ipc.c priority.c
	$(CC) $(CFLAGS) pipe_ipc.c priority.c -o $@.out -lrt -lpthread

#%: %.c priority.c
#	$(CC) $(CFLAGS) $< priority.c -o $@.out -lrt -lpthread

clean:
	$(RM) -f *.o *.out 
