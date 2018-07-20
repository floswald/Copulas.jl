# Compare the performance of Copulas with other packages
#-------------------------------------------------------------------------------
# Pkg.add("DatagenCopulaBased")
# Pkg.add("BenchmarkTools")
using BenchmarkTools
using DatagenCopulaBased
using Copulas
srand(123)

# 2-dimensional Gaussian copula
# rho = 0
rho = 0.
ndraws = 1000000
cop = NormalCopula(2,rho)

# pdf
# [TODO] Compare with RCall?
# dnormCopula([0.5 0.5], cop)

# random draws from 2-d copulas
#-------------------------------
@btime  draws1 = rnormCopula(cop, ndraws)
# 56.056 ms (17 allocations: 30.52 MiB)
@btime  draws2 = gausscopulagen(ndraws, cop.sigma)
# 71.308 ms (26 allocations: 61.04 MiB)
