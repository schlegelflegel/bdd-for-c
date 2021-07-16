#include "bdd-for-c.h"
#include "add.h"

spec("add") {
    describe("add") {
        it("should add positive numbers") {
            expect(add(1, 2)) to_be(3);
        }
    }
}
