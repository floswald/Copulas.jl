# Example
using Copulas

# initialize a Gaussian copula
cop = NormalCopula(2,0.5)

# Take 10 draws from the Gaussian copula defined above
rnormCopula(cop,10)

# Calculate the pdf for a single point:
dnormCopula([0.5 0.5],cop)

# Calculate the pdf for a vector of points
n = 10
u = linspace(1/n, 1-1/n, n)
u2 =[repmat(u,n,1) repmat(u,1,n)'[:] ]
cpd = reshape(dnormCopula(u2,cop),n,n)


