using GLMakie
x = range(0, 10, length=100)
y = sin.(x)
lines(x, y)