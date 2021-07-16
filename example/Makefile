SOURCE_DIR = src
INCLUDE_DIR = include


SOURCES = $(shell find $(SOURCE_DIR) -name "*.c")
OBJS = $(patsubst %.c, %.o, $(SOURCES))

CFLAGS = -I$(INCLUDE_DIR)


.PHONY: all clean


all: $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS)


TEST_SOURCES_COMMON = $(OBJS) # link all object with each test
include ../Makefile # include the bdd-for-c root directory Makefile
