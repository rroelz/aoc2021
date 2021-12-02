input = readlines("input/input1.txt")
global i = 0
global pd = 0
global window_depth = Vector{Int32}()

window = fill(0, 3)
for depth in input
    popfirst!(window)
    push!(window, parse(Int, depth))

    win_sum = sum(window)
    push!(window_depth, win_sum)
end

popfirst!(window_depth)
popfirst!(window_depth)

for depth in window_depth
    d = depth
    if d > pd 
        global i+=1
    end
    global pd = d
end
print(i-1)