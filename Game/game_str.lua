--Put both make_3_digit and add_commas elsewhere.

function p.make_3_digit_big(num)
    --Normal case.
    if( num >= -0.1 and num <  999999999999.0 ) then
        return p.make_3_digit_big_no_sci(num)
    end
    --Getting the expoment.
    local ln1 = math.log10(num)
    local ln2 = math.floor(ln1)
    if( ln2 > 95 ) then return "BIG" end
    if( ln2 < -5 ) then return "SMALL" end
    --Getting the mantissa.
    local mant1 = num * (10 ^ (-ln2))
    local mant2 = math.floor(mant1 * 10)
    --Return sci notation.
    return tostring(mant2) .. "e" .. tostring(ln2-1)
end

function p.make_3_digit(num)
    if( num < 10 ) then return "00" .. tostring(num) end
    if( num < 100 ) then return "0" .. tostring(num) end
    return tostring(num)
end

function p.add_commas(num)
    local ones_rem = num % 1000
    local thousands = math.floor( (num - ones_rem) / 1000 )
    if( thousands == 0 ) then return tostring(num) end
    if( thousands < 1000 ) then
        return tostring(thousands) .. "," .. p.make_3_digit(ones_rem)
    end
    thousands_rem = math.floor(thousands % 1000)
    millions = math.floor( (thousands - thousands_rem) / 1000 )
    if( millions < 1000 ) then
        return tostring(millions) .. ","
            .. p.make_3_digit(thousands_rem) .. ","
            .. p.make_3_digit(ones_rem)
    end
    return tostring(num) --Note that this is wrong if the number is too big.
    --What if the number is even bigger!!!
end

function p.make_3_digit_big_no_sci(num)
    local temp = math.floor(num)
    local digits = {} --In reverse order.
    local i = 0
    while( temp > 0 ) do
        local new_digit = math.floor(temp % 10)
        digits[i] = new_digit
        temp = temp - new_digit
        temp = temp / 10
        i = i + 1
    end
    local digit1 = 0
    local digit2 = 0
    local digit3 = 0
    local digit4 = 0
    local digit5 = 0
    if( i-1 >= 0 ) then digit1 = digits[i-1] end
    if( i-2 >= 0 ) then digit2 = digits[i-2] end
    if( i-3 >= 0 ) then digit3 = digits[i-3] end
    if( i-4 >= 0 ) then digit4 = digits[i-4] end
    if( i-5 >= 0 ) then digit5 = digits[i-5] end

    local s1 = tostring(digit1)
    local s2 = tostring(digit2)
    local s3 = tostring(digit3)
    local s4 = tostring(digit4)
    local s5 = tostring(digit5)

    if( num < 10 ) then
        return s1
    elseif( num < 100 ) then
        return s1 .. s2
    elseif( num < 1000 ) then
        return s1 .. s2 .. s3
    elseif( num < 10000 ) then
        return s1 .. s2 .. s3 .. s4
    elseif( num < 100000 ) then
        return s1 .. s2 .. s3 .. s4 .. s5
    elseif( num < 1000000 ) then
        return s1 .. s2 .. s3 .. "K"
    elseif( num < 10000000 ) then
        return s1 .. "." .. s2 .. s3 .. "M"
    elseif( num < 100000000 ) then
        return s1 .. s2 .. "." .. s3 .. "M"
    elseif( num < 1000000000 ) then
        return s1 .. s2 .. s3 .. "M"
    elseif( num < 10000000000 ) then
        return s1 .. "." .. s2 .. s3 .. "B"
    elseif( num < 100000000000 ) then
        return s1 .. s2 .. "." .. s3 .. "B"
    elseif( num < 1000000000000 ) then
        return s1 .. s2 .. s3 .. "B"
    else
        return "BIG"
    end
end

--Splits into an array,
--using ' ' has a separator.
function p.split(str)
    local array = {}
    local i = 0
    for part in string.gmatch(str, "%S+") do
        i = i + 1
        array[i] = part
    end
    return array
end

--A helper function for the command system.
--Splits into the first string before a ' '
--(the head) and the rest (the tail). 
function p.split_into_head_and_tail(str)
    local array = p.split(str)
    local data = {}
    data.head = ""
    data.tail = ""
    if( #array == 0 ) then return data end
    data.head = array[1]
    for i = 2,#array do
        data.tail = data.tail .. array[i]
        if( i < #array ) then
            data.tail = data.tail .. " "
        end
    end
    return data
end

function p.sort_array_of_strs(array)
    table.sort(array)
    return array
end
