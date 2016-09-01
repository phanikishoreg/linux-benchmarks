CC := gcc
RM := rm
CFLAGS := -O3 -g

all: pipe threads

%: %.c priority.c
	$(CC) $(CFLAGS) $< priority.c -o $@.out -lrt -lpthread

clean:
	$(RM) -f *.o *.out 
