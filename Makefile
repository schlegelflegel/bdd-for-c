# directory to search for tests and their filename pattern
TEST_DIR ?= tests
TEST_PATTERN ?= *.test.c

# test source files. Common sources will be linked to each target
TEST_SOURCES_COMMON ?=
TEST_SOURCES ?= $(shell find $(TEST_DIR) -name "$(TEST_PATTERN)")
TEST_TARGETS = $(patsubst %.c, %.bin, $(TEST_SOURCES))

# include path of bdd-for-c.h. Defaults to this Makefile's directory
BDD_INCLUDE ?= $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# compiler and linker flags
TEST_CFLAGS := $(CFLAGS) $(TEST_CFLAGS) -I$(BDD_INCLUDE) -std=c11 -Wall -Wextra -Werror -pedantic
TEST_LDFLAGS := $(LDFLAGS) $(TEST_LDFLAGS)


.PHONY: test test.run test.clean


# run all tests and remove the binaries
test:
	@$(MAKE) -s test.run
	@$(MAKE) -s test.clean


# run all test targets
test.run: $(TEST_TARGETS)
	$(BDD_INCLUDE)/test.sh $(TEST_TARGETS)

%.bin: %.c $(TEST_SOURCES_COMMON)
	@$(CC) $(TEST_CFLAGS) $(TEST_LDFLAGS) -o $@ $< $(TEST_SOURCES_COMMON)


clean: test.clean
test.clean:
	@rm -f $(TEST_TARGETS)
