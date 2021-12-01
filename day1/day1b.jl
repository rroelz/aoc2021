input = readlines("day1/input1.txt")
global i = 0
global pd = 0
global window_depth = Vector{Int32}()

window = fill(0, 3)
for depth in input
    popat!(window, 1)
    push!(window, parse(Int, depth))

    println(window)

    win_sum = sum(window)
    push!(window_depth, win_sum)
end

window_depth = [1,2,3,2,3,4,3]


for depth in window_depth
    d = depth
    d > pd && global i+=1
    global pd = d
end
print(i-1)