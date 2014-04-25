

# main programme
cd("/Users/florianoswald/git/copula.jl")
include("mods/copula.jl")

cop = copmod.Copula(2,0.5)

copmod.rnormCopula(cp,10)

n =2 
u = linspace(1/n, 1-1/n, n)
u2 =[repmat(u,n,1) repmat(u,1,n)'[:] ]
cpd = reshape(copmod.dnormCopula(u2,cop),n,n)


# run tests
include("test/test_copula.jl")
