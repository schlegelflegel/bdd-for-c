TEST_DIR ?= tests
TEST_PREFIX ?= 
TEST_SUFFIX ?= .test.c

TEST_SOURCES_COMMON ?=
TEST_SOURCES ?= $(shell find $(TEST_DIR) -name "$(TEST_PREFIX)*$(TEST_SUFFIX)")
TEST_TARGETS = $(patsubst %.c, %.bin, $(TEST_SOURCES))

BDD_INCLUDE ?= $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

TEST_CFLAGS := $(CFLAGS) $(TEST_CFLAGS) -I$(BDD_INCLUDE) -std=c11 -Wall -Wextra -Werror -pedantic
TEST_LDFLAGS := $(LDFLAGS) $(TEST_LDFLAGS)


.PHONY: test test.run test.clean


test:
	@$(MAKE) -s test.run
	@$(MAKE) -s test.clean


test.run: $(TEST_TARGETS)
	for test in $^; do \
		./$$test; \
	done;

%.bin: %.c $(TEST_SOURCES_COMMON)
	@$(CC) $(TEST_CFLAGS) $(TEST_LDFLAGS) -o $@ $< $(TEST_SOURCES_COMMON)


clean: test.clean
test.clean:
	@rm -f $(TEST_TARGETS)
