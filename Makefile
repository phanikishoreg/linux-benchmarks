CC := clang
RM := rm
CFLAGS := -O3 -g

WORKSET_16K= 256
WORKSET_24K= 384
WORKSET_32K= 512
WORKSET_48K= 768
WORKSET_64K= 1024
WORKSET_96K= 1536
WORKSET_128K= 2048
WORKSET_192K= 3072
WORKSET_256K= 4096
WORKSET_384K= 6144
WORKSET_512K= 8192
WORKSET_20K= 320
WORKSET_28K= 448
WORKSET_40K= 640
WORKSET_56K= 896
WORKSET_80K= 1280
WORKSET_112K= 1792
WORKSET_160K= 2560
WORKSET_224K= 3584
WORKSET_320K= 5120
WORKSET_448K= 7168


all: pipe_ipc_proc pipe_ipc_thd

pipe_ipc_proc: pipe_ipc.c priority.c
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_16K) -DUSE_FORK pipe_ipc.c priority.c -o $@.16k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_20K) -DUSE_FORK pipe_ipc.c priority.c -o $@.20k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_24K) -DUSE_FORK pipe_ipc.c priority.c -o $@.24k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_28K) -DUSE_FORK pipe_ipc.c priority.c -o $@.28k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_32K) -DUSE_FORK pipe_ipc.c priority.c -o $@.32k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_40K) -DUSE_FORK pipe_ipc.c priority.c -o $@.40k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_48K) -DUSE_FORK pipe_ipc.c priority.c -o $@.48k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_56K) -DUSE_FORK pipe_ipc.c priority.c -o $@.56k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_64K) -DUSE_FORK pipe_ipc.c priority.c -o $@.64k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_80K) -DUSE_FORK pipe_ipc.c priority.c -o $@.80k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_96K) -DUSE_FORK pipe_ipc.c priority.c -o $@.96k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_112K) -DUSE_FORK pipe_ipc.c priority.c -o $@.112k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_128K) -DUSE_FORK pipe_ipc.c priority.c -o $@.128k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_160K) -DUSE_FORK pipe_ipc.c priority.c -o $@.160k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_192K) -DUSE_FORK pipe_ipc.c priority.c -o $@.192k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_224K) -DUSE_FORK pipe_ipc.c priority.c -o $@.224k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_256K) -DUSE_FORK pipe_ipc.c priority.c -o $@.256k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_320K) -DUSE_FORK pipe_ipc.c priority.c -o $@.320k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_384K) -DUSE_FORK pipe_ipc.c priority.c -o $@.384k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_448K) -DUSE_FORK pipe_ipc.c priority.c -o $@.448k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_512K) -DUSE_FORK pipe_ipc.c priority.c -o $@.512k.out -lrt -lpthread

pipe_ipc_thd: pipe_ipc.c priority.c
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_16K) pipe_ipc.c priority.c -o $@.16k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_20K) pipe_ipc.c priority.c -o $@.20k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_24K) pipe_ipc.c priority.c -o $@.24k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_28K) pipe_ipc.c priority.c -o $@.28k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_32K) pipe_ipc.c priority.c -o $@.32k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_40K) pipe_ipc.c priority.c -o $@.40k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_48K) pipe_ipc.c priority.c -o $@.48k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_56K) pipe_ipc.c priority.c -o $@.56k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_64K) pipe_ipc.c priority.c -o $@.64k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_80K) pipe_ipc.c priority.c -o $@.80k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_96K) pipe_ipc.c priority.c -o $@.96k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_112K) pipe_ipc.c priority.c -o $@.112k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_128K) pipe_ipc.c priority.c -o $@.128k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_160K) pipe_ipc.c priority.c -o $@.160k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_192K) pipe_ipc.c priority.c -o $@.192k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_224K) pipe_ipc.c priority.c -o $@.224k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_256K) pipe_ipc.c priority.c -o $@.256k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_320K) pipe_ipc.c priority.c -o $@.320k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_384K) pipe_ipc.c priority.c -o $@.384k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_448K) pipe_ipc.c priority.c -o $@.448k.out -lrt -lpthread
	$(CC) $(CFLAGS) -DWORKSET_TEST_SIZE=$(WORKSET_512K) pipe_ipc.c priority.c -o $@.512k.out -lrt -lpthread

#%: %.c priority.c
#	$(CC) $(CFLAGS) $< priority.c -o $@.out -lrt -lpthread

clean:
	$(RM) -f *.o *.out 
