local numbers = {}

-- Direct recursion (_rec)

function numbers.sum_of_first_n_rec(n)
    if n <= 0 then
        return 0
    end
    return n + numbers.sum_of_first_n_rec(n - 1)
end

function numbers.factorial_rec(n)
    if n <= 0 then
        return 1
    end
    return n * numbers.factorial_rec(n - 1)
end

function numbers.fibonacci_rec(n)
    if n <= 1 then
        return n
    end
    return numbers.fibonacci_rec(n - 1) + numbers.fibonacci_rec(n - 2)
end

function numbers.greatest_common_divisor_rec(a, b)
    if b == 0 then
        return a
    end
    return numbers.greatest_common_divisor_rec(b, a % b)
end

function numbers.least_common_multiple_rec(a, b)
    return (a * b) // numbers.greatest_common_divisor_rec(a, b)
end

-- Accumulator recursion (_acc): educational bridge, no TCO in Lua

local function sum_of_first_n_acc_help(n, acc)
    if n <= 0 then
        return acc
    end
    return sum_of_first_n_acc_help(n - 1, n + acc)
end

function numbers.sum_of_first_n_acc(n)
    return sum_of_first_n_acc_help(n, 0)
end

local function factorial_acc_help(n, acc)
    if n <= 1 then
        return acc
    end
    return factorial_acc_help(n - 1, n * acc)
end

function numbers.factorial_acc(n)
    return factorial_acc_help(n, 1)
end

local function fibonacci_acc_help(n, acc2, acc1)
    if n <= 0 then
        return acc2
    end
    if n <= 2 then
        return acc1 + acc2
    end
    return fibonacci_acc_help(n - 1, acc1, acc1 + acc2)
end

function numbers.fibonacci_acc(n)
    return fibonacci_acc_help(n, 0, 1)
end

local function greatest_common_divisor_acc_help(a, b)
    if b == 0 then
        return a
    end
    return greatest_common_divisor_acc_help(b, a % b)
end

function numbers.greatest_common_divisor_acc(a, b)
    return greatest_common_divisor_acc_help(a, b)
end

function numbers.least_common_multiple_acc(a, b)
    return (a * b) // numbers.greatest_common_divisor_acc(a, b)
end

-- Iterative (_ite)

function numbers.sum_of_first_n_ite(n)
    local result = 0
    for i = 1, n do
        result = result + i
    end
    return result
end

function numbers.factorial_ite(n)
    local result = 1
    for i = 2, n do
        result = result * i
    end
    return result
end

function numbers.fibonacci_ite(n)
    if n <= 1 then
        return n
    end
    local acc2 = 0
    local acc1 = 1
    for i = 2, n do
        local temp = acc1 + acc2
        acc2 = acc1
        acc1 = temp
    end
    return acc1
end

function numbers.greatest_common_divisor_ite(a, b)
    local x = a
    local y = b
    while y ~= 0 do
        local temp = y
        y = x % y
        x = temp
    end
    return x
end

function numbers.least_common_multiple_ite(a, b)
    return (a * b) // numbers.greatest_common_divisor_ite(a, b)
end

return numbers
