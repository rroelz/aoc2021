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
    while i <= 10
        if nums[i] == segments_on
            return i-1
            break
        end
    i+=1
    end
    return false
    print("ERROR: parsing $segments_on not possible")
end

function translate(signal, decoder_array)
    translation = ""
    signal_arr = split(signal, "")
    for s in signal_arr
        i = 1
        found = false
        while found == false
            if s == decoder_array[i]
                translation*= possible_segments[i]
                found = true
            end
            i+=1
        end           
    end
    return translation
end

function unjumble(jumble)
    one = jumble[findfirst(x ->  length(x) == 2, jumble)]
    four = jumble[findfirst(x ->  length(x) == 4, jumble)]
    seven = jumble[findfirst(x ->  length(x) == 3, jumble)]
    eight = jumble[findfirst(x ->  length(x) == 7, jumble)]

    decoder_array = ["" for x in 1:7]
    
    #find segment a 
    for a in seven
        if !occursin(a, one)
            decoder_array[1]*= a
        end 
    end

    #find g
    four_a = four*decoder_array[1]
    for num in jumble[findall(x ->  length(x) == 6, jumble)]
        for g in num
            if !occursin(g, four_a)
            decoder_array[7]*= g
            end
        end
        if length(decoder_array[7]) == 1
            break
        else
            decoder_array[7] = ""
        end
    end

    #find nine
    nine = four_a*decoder_array[7]
    
    #find  e
    for e in eight
        if !occursin(e, nine)
            decoder_array[5]*= e
        end 
    end

    # find c
    four_a = four*decoder_array[1]
    for num in jumble[findall(x ->  length(x) == 5, jumble)]
        if occursin(decoder_array[5], num) #check for e, only 2 is 5 long and has e
            for c in num
                if occursin(c, one)
                decoder_array[3]*= c
                end
            end
        end
    end

    #find f
    for f in one
        if !occursin(f, decoder_array[3]) #zwei Elemente in eins, wähle aus was nicht c ist
            decoder_array[6] *= f
        end
    end

    #find d
    foundsofar = ""
    for n in decoder_array
        foundsofar*=n
    end
    for num in jumble[findall(x ->  length(x) == 5, jumble)]
        if occursin(decoder_array[3], num) && occursin(decoder_array[6], num) #check for c and f, only 3 is 5 long and has both
            for d in num
                if !occursin(d, foundsofar) #find the one that hasn't been set in three
                decoder_array[4]*= d
                end
            end
        end
    end
    
    #find b
    foundsofar*=decoder_array[4]
    for b in possible_segments
        if !occursin(b, foundsofar)
            decoder_array[2]*= b
        end
    end

    return decoder_array
end

input = readlines("input/8")
#input = ["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf", 
#"be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe"]
signals = split.(input, " | ")
number_jumble = []
display_output = []
for signal in signals
    push!(number_jumble, split(signal[1], " "))
    push!(display_output, split(signal[2], " "))
end

score = 0
for i in 1:length(number_jumble)
    decoder_array = unjumble(number_jumble[i])
    score_here = ""
    for num in display_output[i]
        output_num = parse_segments(translate(num, decoder_array))
        score_here*=string(output_num)
    end
    global score+=parse(Int, score_here)
end
print("Yout total score is $score")

using Combinatorics

all_decoders = permutations(possible_segments)
for i in 1:length(number_jumble)
    for decoder in all_decoders
        n_correct = 0
        for num in number_jumble[i]
            if parse_segments(translate(num, decoder)) == false
                break
            else
                n_correct+=1
            end
            if n_correct == 10
                score_here = ""
                for num in display_output[i]
                    output_num = parse_segments(translate(num, decoder_array))
                    score_here*= string(output_num)
                end
                global score+=parse(Int, score_here)
            end
        end
    end        
end
       
println("Yout brute forced score is $score")
