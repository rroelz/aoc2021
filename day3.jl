input = readlines("input/3")

input_matrix = [parse(Int, input[y][x]) for y = 1:length(input), x=1:length(input[1])]
gamma =""
epsilon ="" 

for i in 1:size(input_matrix)[2]
    s = sum(input_matrix[:, i])
    if s > size(input_matrix)[1]/2
        global gamma *= "1"
        global epsilon *= "0"
    else
        global gamma *= "0"
        global epsilon *= "1"
    end
end

gammaval = parse(Int, gamma, base = 2)
epsilonval = parse(Int, epsilon, base = 2)
powercon = gammaval*epsilonval

println("gamma is $gammaval and epsilon is $epsilonval \n 
Power consumption is $powercon")


oxg = ""
oxg_matrix = copy(input_matrix)
i=1
while size(oxg_matrix)[1]>1 
    s = sum(oxg_matrix[:, i])
    if s >= size(oxg_matrix)[1]/2
        keep = 1
    else
        keep = 0
    end
    idx = findall(oxg_matrix[:,i].==keep)
    global oxg_matrix = oxg_matrix[idx, :]
    global i+=1
end

for bin in string.(oxg_matrix)
    global oxg*=bin
end

co2= ""
co2_matrix = copy(input_matrix)
i=1
while size(co2_matrix)[1]>1 
    s = sum(co2_matrix[:, i])
    if s >= size(co2_matrix)[1]/2
        keep = 0
    else
        keep = 1
    end
    idx = findall(co2_matrix[:,i].==keep)
    global co2_matrix = co2_matrix[idx, :]
    global i+=1
end

for bin in string.(co2_matrix)
    global co2*=bin
end



oxval = parse(Int, oxg, base = 2)
co2val = parse(Int, co2, base = 2)
life_support = oxval*co2val

println("Oxygen generator rating: $oxval
CO2 scrubber rating: $co2val
Life support rating at: $life_support")