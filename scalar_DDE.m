function dy = scalar_DDE(y, z)
    lambda = - 100;
    mu = 2;
    dy = lambda*y + mu*z;
end