#include <limits.h>

#include "bdd-for-c.h"


typedef enum example_enum {
    state1,
    state2,
    state3
} example_enum;

int sum(int a, int b) {
    return a + b;
}

int increment_and_return(int *x) {
    return ++(*x);
}

spec("bdd-for-c expect") {
    static example_enum e1, e2, *e1_ptr;    
    static int counter;

    static const int numbers[] = { 0, 1, 2, 3 };
    static const char *str1 = "hello";

    before_each() {
        e1 = state1;
        e2 = state2;
        e1_ptr = &e1;

        counter = 0;
    }

    describe("to_be matcher") {
        it("should work for scalar values") {
            expect(0) to_be(0);
            expect('a') to_be('a');
            expect(e2) to_be(state2);
            expect(e1_ptr) to_be(&e1);
        }

        it("should work for any integer") {
            expect(LLONG_MIN) to_be(LLONG_MIN);
            expect(ULLONG_MAX) to_be(ULLONG_MAX);
        }

        it("should work for static expressions") {
            expect(1 + 2) to_be(3);
            expect(sum(1, 2)) to_be(3);
            expect(numbers[2]) to_be(2);
        }

        it("should work for dynamic expressions") {
            expect(increment_and_return(&counter)) to_be(1);
            expect(increment_and_return(&counter)) to_be(2);
        }

        it("should compare strings") {
            expect(str1) to_be("hello");
            expect(str1) not to_be("world");
            expect(str1) to_be("hell no", 4); // limit to 4 characters
        }
    }

    describe("inequality matchers") {
        it("should work on <") {
            expect(0) to_be_less_than(1);
            expect(0) not to_be_less_than(0);
        }

        it("should work on <=") {
            expect(0) to_be_less_than_or_equal_to(0);
            expect(0) not to_be_less_than_or_equal_to(-1);
        }

        it("should work on >") {
            expect(0) to_be_greater_than(-1);
            expect(0) not to_be_greater_than(0);
        }

        it("should work on >=") {
            expect(0) to_be_greater_than_or_equal_to(0);
            expect(0) not to_be_greater_than_or_equal_to(1);
        }
    }

    describe("to_be_close_to matcher") {
        it("should work for static expressions") {
            expect(1.0f - 0.4f) to_be_close_to(0.6f);
            expect(0.6000001f) to_be_close_to(0.6f);
        }

        it("should accept a precision argument") {
            expect(5.01f) to_be_close_to(5.0f, 0.1f);
            expect(5.01f) not to_be_close_to(5.0f, 0.001f);
        }
    }
}
