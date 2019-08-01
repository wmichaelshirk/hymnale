function isOdd(num)
    return math.mod(num, 2) ~= 0
end

function gsplit(s,sep)
    return coroutine.wrap(function()
        if s == '' or sep == '' then
            coroutine.yield(s)
            return
        end
        local lasti = 1
        for v,i in s:gmatch('(.-)'..sep..'()') do
            coroutine.yield(v)
            lasti = i
        end
        coroutine.yield(s:sub(lasti))
    end)
end
function accumulate(t,i,s,v)
    for v in i,s,v do
       t[#t+1] = v
    end
    return t
end
function tsplit(s,sep)
    return accumulate({}, gsplit(s,sep))
end

function printhymn(text)
    tex.print("\\begin{hangparas}{.25in}{1}")
    tex.print("\\footnotesize")
    tex.print("\\begin{multicols}{2}")
    local newPar = "\\par\r "
    local splitVerses = tsplit(text:gsub(string.char(10), newPar), newPar:rep(2))
    local lastVerse
    if isOdd(#splitVerses) then
        lastVerse = table.remove(splitVerses)
    end
    tex.print(table.concat(splitVerses, "\\medskip\r "))
    tex.print("\\end{multicols} ")
    tex.print(lastVerse)
    tex.print("\\end{hangparas} ")
end