xpos = 0
ypos = 0
aim = 0

instructions = readlines("input/input2.txt")

for line in instructions
    dir = split(line, " ")
    val = parse(Int, dir[2])
    if dir[1] == "forward"
        global xpos = xpos+val
        global ypos = ypos+(aim*val)
    end
    dir[1] == "down" && global aim = aim+val
    dir[1] == "up" && global aim = aim-val
end

println("Current position: $xpos \nCurrent depth at: $ypos")
println(xpos*ypos)