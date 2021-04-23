using Plots
using QuadGK
using LaTeXStrings

r_vals = [2, 3, 4, 5, 6]
λ_vals = 0.1:0.01:1

function get_ϕ(r, λ)
    return (t) -> sum([(1 / factorial(n)) * exp(-λ*t) * (λ*t)^n for n = 0:r-1])
end

function get_integrand(ϕ)
    return (t) -> 2 * ϕ(t)^7 - ϕ(t)^9
end

plot()
for r in r_vals
    mean_t = [quadgk(get_integrand(get_ϕ(r, λ)), 0, Inf, rtol=1e-4)[1] for λ in λ_vals]
    plot!(λ_vals, mean_t, label="r = $r",
                            xlabel=L"$\lambda$",
                            ylabel=L"$\overline{t}$",
                            dpi=300)
end
savefig("erlang.png")
