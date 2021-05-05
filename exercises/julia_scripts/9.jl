using Plots
using LaTeXStrings

z2(a) = (1 - a - sqrt((1+3a)*(1-a))) / 2a

function C(a)
    z = z2(a)
    n = a*z + z - (a*z)^3 * (1-a) / (1-a*z) -
                        (1-a)*a*z - z^2 - a^2 * (1-a) * z^2
    d = (a * z)^2 / (1-a) + a*z - a/(1-a)
    return n / d
end

function D(a)
    n = C(a) * (2a^2 / (1-a) + a) + a^3 / (1-a) + a^2 - a + 1
    d = 2 - 3a
    return n / d
end

x1(a) = (1-a) / (C(a) + a + (1-a)*D(a))
x0(a) = C(a) * x1(a)

function mean(a)
    n = (1-a)^3 * D(a) + 1 - 3a + 5a^2 - 2a^3
    d = (1-a)^2 * (2-3a)
    return x1(a) * n / d
end

a = 0.001:0.001:0.6
plot(a, x1.(a), label=L"P_{(0, 1)}", dpi=300, color="royalblue3")
scatter!([0], [0], markerstrokecolor="royalblue3",
                    label="", color="white", markersize=2.5)
plot!(a, x0.(a), label=L"P_{(0, 0)}", color="darkred")
scatter!([0], [1], markerstrokecolor="darkred",
                    label="", color="white", markersize=2.5)
savefig("plot1.pdf")

a′ = 0.001:0.001:0.66
ticks = collect(0:0.1:0.5)
plot(a′, mean.(a′), label=L"\mathbf{M}[n+s]", dpi=300, color="seagreen",
    legend=:topleft, xticks=(ticks ∪ [2/3],
                            string.(ticks) ∪ [L"\frac{2}{3}"]))
savefig("plot2.pdf")
