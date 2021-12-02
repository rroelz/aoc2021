using Plots

xpos = 0
ypos = 0
aim = 0

instructions = readlines("input/input2.txt")

#= pos_hist = zeros(Int64, 1, 2)

for line in instructions
    dir = split(line, " ")
    val = parse(Int, dir[2])
    dir[1] == "forward" && global xpos = xpos+val
    dir[1] == "down" && global ypos = ypos+val
    dir[1] == "up" && global ypos = ypos-val
    global pos_hist = vcat(pos_hist, [xpos ypos])
end

println("Current position: $xpos \nCurrent depth at: $ypos")
println(xpos*ypos) =#


pos_hist = zeros(Int64, 1, 3)

for line in instructions
    dir = split(line, " ")
    val = parse(Int, dir[2])
    if dir[1] == "forward"
        global xpos = xpos+val
        global ypos = ypos+(aim*val)
    end
    dir[1] == "down" && global aim = aim+val
    dir[1] == "up" && global aim = aim-val
    global pos_hist = vcat(pos_hist, [xpos ypos aim])
end

println("Current position: $xpos \nCurrent depth at: $ypos")
println(xpos*ypos)

gr()
plot(pos_hist[:, 1], -pos_hist[:, 2], xlims = (0, 2000), ylims = (- 1050000, 0), 
    linecolor = "white", background_color = "darkcyan", 
    xlabel = "distance", ylabel = "depth")
scatter!(pos_hist[1000, 1], -pos_hist[1000, 2], markersize=[10000], color = "black")

p = plot(pos_hist[1, 1], -pos_hist[1, 2], 
    #xlims = (0, 2000), ylims = (- 1000, 0),
    title = "Travels of the Submarine")
anim = Animation()

lastvals = repeat([last(pos_hist[:, 1]) last(pos_hist[:, 2])], outer = 100)
pos_hist_gif = vcat(pos_hist[:,1:2], lastvals)


 submarine = @animate for i=1:size(pos_hist_gif, 1)
    plot(p, pos_hist_gif[1:i, 1], -pos_hist_gif[1:i, 2], 
    xlims = (0, 2000), ylims = (- 1050000, 0),
    title = "Travels of the Submarine", 
    linecolor = "white", background_color = "darkcyan", 
    xlabel = "distance", ylabel = "depth", 
    label = "Submarine Path")
    frame(anim)
end every 5
gif(submarine, "plots/submarineb.gif", fps = 25)