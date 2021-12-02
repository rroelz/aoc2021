xpos = 0
ypos = 0

instructions = readlines("day2/input2.txt")

for line in instructions
    dir = split(line, " ")
    val = parse(Int, dir[2])
    dir[1] == "forward" && global xpos = xpos+val
    dir[1] == "down" && global ypos = ypos+val
    dir[1] == "up" && global ypos = ypos-val
end

println("Current position: $xpos \nCurrent depth at: $ypos")
println(xpos*ypos)