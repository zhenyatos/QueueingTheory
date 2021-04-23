using Plots
using QuadGK
using LaTeXStrings

λ_vals = 0.1:0.01:1
ϰ_vals = 0.1:0.01:1

function get_ϕ(ϰ, λ)
    return (t) -> ϰ * exp(-2ϰ*λ*t) + (1 - ϰ) * exp(2(ϰ-1)λ*t)
end

function get_integrand(ϕ)
    return (t) -> 2 * ϕ(t)^7 - ϕ(t)^9
end

mean_t = [quadgk(get_integrand(get_ϕ(ϰ, λ)), 0, Inf, rtol=1e-4)[1] for λ in λ_vals,
                                                                    ϰ in ϰ_vals]
surface(ϰ_vals, λ_vals, mean_t, camera=(30, 60),
                                xlabel=L"$\varkappa$",
                                ylabel=L"$\lambda$",
                                zlabel=L"$\overline{t}$",
                                dpi=300)
savefig("morse1.png")

surface(ϰ_vals, λ_vals, mean_t, camera=(60, 80),
                                xlabel=L"$\varkappa$",
                                ylabel=L"$\lambda$",
                                zlabel=L"$\overline{t}$",
                                dpi=300)
savefig("morse2.png")
