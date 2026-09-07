package.path = "./src/?.lua;" .. package.path

local numbers = require("numbers")

describe("numbers recursive", function()
    it("sum_of_first_n_rec", function()
        assert.are.equal(0, numbers.sum_of_first_n_rec(0))
        assert.are.equal(6, numbers.sum_of_first_n_rec(3))
    end)

    it("factorial_rec", function()
        assert.are.equal(1, numbers.factorial_rec(0))
        assert.are.equal(24, numbers.factorial_rec(4))
    end)

    it("fibonacci_rec", function()
        assert.are.equal(0, numbers.fibonacci_rec(0))
        assert.are.equal(1, numbers.fibonacci_rec(1))
        assert.are.equal(8, numbers.fibonacci_rec(6))
    end)

    it("greatest_common_divisor_rec", function()
        assert.are.equal(4, numbers.greatest_common_divisor_rec(12, 8))
        assert.are.equal(1, numbers.greatest_common_divisor_rec(7, 5))
    end)

    it("least_common_multiple_rec", function()
        assert.are.equal(12, numbers.least_common_multiple_rec(4, 6))
        assert.are.equal(24, numbers.least_common_multiple_rec(6, 8))
    end)
end)
