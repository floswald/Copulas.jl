

# main programme
cd("/Users/florianoswald/git/Copulas.jl")
include("src/copula.jl")

cop = Copulas.NormalCopula(2,0.5)

Copulas.rnormCopula(cop,10)

n =2 
u = linspace(1/n, 1-1/n, n)
u2 =[repmat(u,n,1) repmat(u,1,n)'[:] ]
cpd = reshape(Copulas.dnormCopula(u2,cop),n,n)


# run tests
include("test/test_copula.jl")
