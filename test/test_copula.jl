

module test_copula

using FactCheck
using copmod

facts("testing default constructor") do
	
	ndim = 3
	rho  = 0.5

	c = copmod.Copula(ndim,rho)
	@fact c.rho => rho
	@fact c.d   => ndim
	sig = rho.^abs(linspace(1,ndim,ndim) .- linspace(1,ndim,ndim)')
	@fact c.sigma => sig

	ndim = 2
	rho  = 0.9
	c = copmod.Copula(ndim,rho)
	@fact c.rho => rho
	@fact c.d   => ndim
	sig = rho.^abs(linspace(1,ndim,ndim) .- linspace(1,ndim,ndim)')
	@fact c.sigma => sig
end


facts("testing copula density functions") do

	# rho = .5
	ndim = 2
	rho  = 0.5
	n = 2 # numpoints
	cop = copmod.Copula(ndim,rho)
	u = linspace(1/n, 1-1/n, n)
	u2 =[repmat(u,n,1) repmat(u,1,n)'[:] ]

# computed in R:
# library(copula)
# n=2
# Qn = seq(1/n, 1 - 1/n, l = n)
# vals = expand.grid(p = Qn, p2 = Qn)
# cop = normalCopula(0.5)
# Rdcopula = dCopula(as.matrix(vals), cop)

	Rdcopula = [1.154701*1 for i=1:4]	

	@fact copmod.dnormCopula(u2,cop)[:] => roughly(Rdcopula[:])

	# rho = .9
	rho  = 0.9
	cop = copmod.Copula(ndim,rho)
	Rdcopula = [2.294157*1 for i=1:4]	
	@fact copmod.dnormCopula(u2,cop)[:] => roughly(Rdcopula[:])

	# n = 3. 3 points
	n = 3
	rho  = 0.5
	cop = copmod.Copula(ndim,rho)
	u = linspace(1/n, 1-1/n, n)
	u2 =[repmat(u,n,1) repmat(u,1,n)'[:] ]
	Rdcopula = [1.2283 1.1195 0.9591 1.1195 1.1547 1.1195 0.9591 1.1195 1.2283]	
	@fact copmod.dnormCopula(u2,cop)[:] => roughly(Rdcopula[:],atol=0.0001)

end






end