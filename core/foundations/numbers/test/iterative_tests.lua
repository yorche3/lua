package.path = "./src/?.lua;" .. package.path

local numbers = require("numbers")

describe("numbers iterative", function()
    it("sum_of_first_n_ite", function()
        assert.are.equal(0, numbers.sum_of_first_n_ite(0))
        assert.are.equal(6, numbers.sum_of_first_n_ite(3))
    end)

    it("factorial_ite", function()
        assert.are.equal(1, numbers.factorial_ite(0))
        assert.are.equal(24, numbers.factorial_ite(4))
    end)

    it("fibonacci_ite", function()
        assert.are.equal(0, numbers.fibonacci_ite(0))
        assert.are.equal(1, numbers.fibonacci_ite(1))
        assert.are.equal(8, numbers.fibonacci_ite(6))
    end)

    it("greatest_common_divisor_ite", function()
        assert.are.equal(4, numbers.greatest_common_divisor_ite(12, 8))
        assert.are.equal(1, numbers.greatest_common_divisor_ite(7, 5))
    end)

    it("least_common_multiple_ite", function()
        assert.are.equal(12, numbers.least_common_multiple_ite(4, 6))
        assert.are.equal(24, numbers.least_common_multiple_ite(6, 8))
    end)
end)
