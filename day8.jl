#7 segment display 
nums = [[1,1,1,0,1,1,1], 
[0,0,1,0,0,1,0],
[1,0,1,1,1,0,1],
[1,0,1,1,0,1,1],
[0,1,1,1,0,1,0],
[1,1,0,1,0,1,1],
[1,1,0,1,1,1,1],
[1,0,1,0,0,1,0],
[1,1,1,1,1,1,1],
[1,1,1,1,0,1,1]]
 
possible_segments = ["a", "b", "c", "d", "e", "f", "g"]

function count1478(display)
    i = 0 
    for line in display
        for number in line
            if length(number) in [2,3,4,7] 
                i+=1
            end
        end
    end
    return i
end

function parse_segments(segments)
    segments_on = zeros(Int, 7)
    i=1
    for s in possible_segments
        if occursin(s, segments)
            segments_on[i] = 1
        end
        i+=1
    end
    i = 1
    while i < 10
        if nums[i] == segments_on
            return i-1
            break
        end
    i+=1
    end
    return false
    print("ERROR: parsing $segments_on not possible")
end

function translate(signal, identity)
    translation = ""
    signal_arr = split(signal, "")
    for s in signal_arr
        i = 1
        found = false
        while found == false
            if s == identity[i]
                translation*= possible_segments[i]
                found = true
            end
            i+=1
        end           
    end
    return translation
end

function unjumble(jumble, output)
    one = jumble[findfirst(x ->  length(x) == 2, jumble)]
    four = jumble[findfirst(x ->  length(x) == 4, jumble)]
    seven = jumble[findfirst(x ->  length(x) == 3, jumble)]
    eight = jumble[findfirst(x ->  length(x) == 7, jumble)]

    identity = ["" for x in 1:7]
    
    #find segment a 
    for a in seven
        if !occursin(a, one)
            identity[1]*= a
        end 
    end


end

input = readlines("input/8")
signals = split.(input, " | ")
number_jumble = []
display_output = []
for signal in signals
    push!(number_jumble, split(signal[1]))
    push!(display_output, split(signal[2]))
end

#count1478(display_output)
