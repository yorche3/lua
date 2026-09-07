package.path = "./src/?.lua;" .. package.path

local calculator = require("calculator")

describe("calculator", function()
    it("addition(2, 3) returns 5", function()
        assert.are.equal(5, calculator.addition(2, 3))
    end)

    it("subtraction(5, 2) returns 3", function()
        assert.are.equal(3, calculator.subtraction(5, 2))
    end)

    it("multiplication(3, 4) returns 12", function()
        assert.are.equal(12, calculator.multiplication(3, 4))
    end)

    it("division(10, 3) returns 3", function()
        assert.are.equal(3, calculator.division(10, 3))
    end)

    it("modulus(10, 3) returns 1", function()
        assert.are.equal(1, calculator.modulus(10, 3))
    end)
end)
