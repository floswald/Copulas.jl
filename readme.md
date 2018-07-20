

# Julia Copulas Package

[![Build Status](https://travis-ci.com/JulienPascal/Copulas.jl.svg?branch=master)](https://travis-ci.com/JulienPascal/Copulas.jl)

[![Coverage Status](https://coveralls.io/repos/JulienPascal/Copulas.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/JulienPascal/Copulas.jl?branch=master)

[![codecov.io](http://codecov.io/github/JulienPascal/Copulas.jl/coverage.svg?branch=master)](http://codecov.io/github/JulienPascal/Copulas.jl?branch=master)

This package implements the [gaussian AR1 copula](http://en.wikipedia.org/wiki/Copula_(probability_theory)). So far there are only the density and the random methods.

This is work in progress and I'll be unlikely to do much work on this anytime soon. Any contributions more than welcome.

## Installation
This package can be installed by running
```julia
Pkg.clone("https://github.com/floswald/Copulas.jl.git")
```

## Gaussian AR1 Copula
We want to draw 10 observations from a 2-dimensional Gaussian copula with
correlation coefficient \rho equal to 0.5. The first step is to set up the environment
```julia
using Copulas
srand(123)
```
We create a 2-dimensional Gaussian, first specifying the dimension, then the
parameter rho
```julia
cop = NormalCopula(2,0.5)
```
We can then take 10 draws from the copula we just created
```julia
rnormCopula(cop,10)
```
We can also calculate the pdf for single point
```julia
dnormCopula([0.5 0.5],cop)
```
or for a vector of points:
```julia
n = 100
u = linspace(1/n, 1-1/n, n)
u2 =[repmat(u,n,1) repmat(u,1,n)'[:] ]
dnormCopula(u2,cop)
```

## Benchmark
In terms of sampling, an alternative to Copulas is [DatagenCopulaBased](https://github.com/ZKSI/DatagenCopulaBased.jl),
which supports many copula families. In terms of Gaussian copulas, Copulas seems
to have a slight advantage in terms of speed:
```julia
using BenchmarkTools
using DatagenCopulaBased
using Copulas
srand(123)

# 2-dimensional Gaussian copula
rho = 0.
ndraws = 1000000
cop = NormalCopula(2,rho)

# random draws from 2-dimensional Gaussian copulas
#-------------------------------------------------
@btime  draws1 = rnormCopula(cop, ndraws)
# 56.056 ms (17 allocations: 30.52 MiB)
@btime  draws2 = gausscopulagen(ndraws, cop.sigma)
# 71.308 ms (26 allocations: 61.04 MiB)
```
