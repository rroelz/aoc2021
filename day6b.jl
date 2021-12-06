input = readline("input/6")
maxdays = 256
init_days = parse.(Int8, split(input, ","))
school = zeros(Int, maxdays, 3)
for day in init_days
    school[day, 1] = size(init_days)[1]
    school[day, 2]+=1
end

for day in 1:maxdays
    if day > 1 
        school[day, 3] = school[day-1, 2]
    end
    if day > 7
        school[day, 2] = school[day-7, 2]
    end
    if day > 8
        school[day, 2] += school[day-8, 3]
    end
    if day > 1
        school[day, 1] = school[day-1] + school[day, 3]  
    end
    println(day, ": ", school[day, :]) 
end
#println(school)
schoolsize = school[end, 1]
print("after $maxdays days there are $schoolsize fish")