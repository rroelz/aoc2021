"checks the called numbers on a board"
function checkboard(board, draws)
    checks = findall(x -> x in draws, board)
    checked = fill(false, size(board))
    checked[checks] .= true
    return checked
end

"""
isbingo(Matrix, Array)
checks a board if with the so far drawn numbers there's a bingo
"""

function isbingo(board::Matrix, draws::Array)
    checked = checkboard(board, draws)
    bingoval = false
    for row in eachrow(checked)
        if !(false in row)
            bingoval = true
        end
    end
    for col in eachcol(checked)
        if !(false in col)
            bingoval = true
        end
    end
    return bingoval
end

"""
score(board, numbers)
"""
function score(board, draws)
    notmarked = [!x for x = checkboard(board, draws)]
    score = sum(board[notmarked])*draws[end]
    println("The score of this board is $score")
end

input = readlines("input/4_test")
draws = parse.(Int, split(popfirst!(input), ","))

boards = []
while length(input) > 1
    popfirst!(input)
    board = Matrix{Int}(undef, 5,5)
    for i in 1:5
        board[i, :] =  parse.(Int, split(popfirst!(input)))
    end
    push!(boards, board)
end

i=1
bingo = false
while bingo == false
    drawn = draws[1:i]
    for board in boards
        global bingo = isbingo(board, drawn)
        if bingo == true
            println("This is the firsr board to win:")
            score(board, drawn)
            break
        end           
    end
    global i+=1
end

n_to_bingo = fill(1, 100)

i=1
for board in boards
    for n in 1:length(draws)
        isbingo(board, draws[1:n]) == true && break
        n_to_bingo[i]+=1
    end
    global i+=1
end
lastbingo = findmax(n_to_bingo)
lastdraws = lastbingo[1]
lastboard = lastbingo[2]

println("The last board (board nr. $lastboard) wins after $lastdraws draws\nthis is its score:")
score(boards[lastboard], draws[1:lastdraws])