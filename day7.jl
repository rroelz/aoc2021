function fuel_needed(crab, target)
    fuel = crab - target
    if fuel < 0
        fuel = -fuel
    end
    return fuel
end

function fuel_needed_score(crab, target)
    n = fuel_needed(crab, target)
    sum(collect(0:n))
end

input = readline("input/7")
crab = parse.(Int, split(input, ","))

fueltarget = Inf
targetpos = 0
for i in 1:findmax(crab)[1]
    newfuel = sum(fuel_needed_score.(crab, i))
    if newfuel < fueltarget
        global fueltarget = newfuel
        global targetpos = i
    end
end

println("Command to gather crabs at $targetpos
Total fuel consumption will be $fueltarget")