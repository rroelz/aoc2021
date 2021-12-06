using GLMakie

input = readlines("input/5")
ventmap = zeros(Int, 1000, 1000)
for line in input
    a, b = split(line, " -> ")

    x1, y1 = parse.(Int64, split(a, ",")).+1
    x2, y2 = parse.(Int64, split(b, ",")).+1

    if (x1==x2) | (y1==y2)
        ventmap[x1:x2, y1:y2].+=1
        ventmap[x1:-1:x2, y1:-1:y2].+=1
    else
        xcoords = collect(range(x1,x2, step = 1))
        ycoords = collect(range(y1,y2, step = 1))
        
        if isempty(xcoords) 
            xcoords = collect(range(x1, x2, step = -1))
        end
        if isempty(ycoords) 
            ycoords = collect(range(y1, y2, step = -1))
        end
        coords = []
        for i in 1:length(xcoords)
            ventmap[xcoords[i], ycoords[i]] +=1
        end
    end 
end

overlap = count(i -> (i>=2), ventmap)
ventmap
print("Black smokers overlap at $overlap points"