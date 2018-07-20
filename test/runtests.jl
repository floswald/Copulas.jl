using Copulas
using Base.Test
using DatagenCopulaBased #To test the random sampler. Pkg.add("DatagenCopulaBased")

tolTest = 0.001
print("Testing with tolerance level = $(tolTest)")

@testset "testing default constructor" begin

	ndim = 3
	rho  = 0.5

	c = NormalCopula(ndim,rho)
	@test c.rho == rho
	@test c.d   == ndim
	sig = rho.^abs.(linspace(1,ndim,ndim) .- linspace(1,ndim,ndim)')
	@test c.sigma == sig

	ndim = 2
	rho  = 0.9
	c = NormalCopula(ndim,rho)
	@test c.rho == rho
	@test c.d   == ndim
	sig = rho.^abs.(linspace(1,ndim,ndim) .- linspace(1,ndim,ndim)')
	@test c.sigma == sig

end


@testset "testing copula density functions" begin

	# rho = .5
	ndim = 2
	rho  = 0.5
	n = 2 # numpoints
	cop = NormalCopula(ndim,rho)
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

	@test dnormCopula(u2,cop)[:] ≈ Rdcopula[:] atol = tolTest

	# rho = .9
	rho  = 0.9
	cop = NormalCopula(ndim,rho)
	Rdcopula = [2.294157*1 for i=1:4]
	@test dnormCopula(u2,cop)[:]  ≈ Rdcopula[:] atol = tolTest

	# n = 3. 3 points
	n = 3
	rho  = 0.5
	cop = NormalCopula(ndim,rho)
	u = linspace(1/n, 1-1/n, n)
	u2 =[repmat(u,n,1) repmat(u,1,n)'[:] ]
	Rdcopula = [1.2283 1.1195 0.9591 1.1195 1.1547 1.1195 0.9591 1.1195 1.2283]
	@test dnormCopula(u2,cop)[:]  ≈ Rdcopula[:] atol = tolTest

end

@testset "testing random sampling" begin

	srand(123)

	# 2-dimensional Gaussian copula
	# rho = 0
	rho = 0.
	ndraws = 2000000
	cop = NormalCopula(2,rho)

	#-------------------------------------------------------------------------------
	# The sample mean from DatagenCopulaBased and Copulas should be close
	# when ndraws is large. Idem for the sample variance
	#-------------------------------------------------------------------------------
	draws1 = rnormCopula(cop, ndraws)'
	draws2 = gausscopulagen(ndraws, [1. 0.; 0. 1.])

	# Sample mean:
	#-------------
	# mean along the first dimension
	mean1_x = mean(draws1[:,1])
	# mean along the first dimension
	mean1_y = mean(draws1[:,2])

	# mean along the first dimension
	mean2_x = mean(draws2[:,1])
	# mean along the first dimension
	mean2_y = mean(draws2[:,2])

	# Sample variance
	#-------------------
	var1_x =  var(draws1[:,1])
	var1_y =  var(draws1[:,2])

	var2_x = var(draws2[:,1])
	var2_y = var(draws2[:,2])

	# Should be true if ndraws if large enough:
	#-----------------------------------------
	@test mean1_x ≈ mean2_x atol = tolTest
	@test mean1_y ≈ mean2_y atol = tolTest

	@test var1_x ≈ var2_x atol = tolTest
	@test var1_y ≈ var2_y atol = tolTest

end
