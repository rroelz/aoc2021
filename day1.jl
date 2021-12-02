input = readlines("input/input1.txt")
global i = 0
global pd = 0
for depth in input
    d = parse(Int, depth)
    d > pd && global i+=1
    global pd = d
end
print(i-1)