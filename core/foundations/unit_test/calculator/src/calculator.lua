local calculator = {}

function calculator.addition(a, b)
    return a + b
end

function calculator.subtraction(a, b)
    return a - b
end

function calculator.multiplication(a, b)
    local result = 0
    for _ = 1, b do
        result = calculator.addition(result, a)
    end
    return result
end

function calculator.division(a, b)
    local quotient = 0
    while a >= b do
        a = calculator.subtraction(a, b)
        quotient = calculator.addition(quotient, 1)
    end
    return quotient
end

function calculator.modulus(a, b)
    local q = calculator.division(a, b)
    local p = calculator.multiplication(q, b)
    return calculator.subtraction(a, p)
end

return calculator
