mutable struct Fish
    counter::Int8
end

function init_fish(begin_days)
    school = []
    for day in begin_days
        new_fish = Fish(day)
        push!(school, new_fish)
    end
    return school
end


function spawn!(school)
    for fish in school
        if fish.counter == 0
            fish.counter = 6
            new_fish = Fish(9)
            push!(school, new_fish)
        else
            fish.counter-=1
        end
    end
end


input = readline("input/6")
maxdays = 256
init_days = parse.(Int8, split(input, ","))
school = init_fish(init_days)

for day in 1:maxdays
    spawn!(school)
end
schoolsize = size(school)[1]
print("after $maxdays days there are $schoolsize fish")