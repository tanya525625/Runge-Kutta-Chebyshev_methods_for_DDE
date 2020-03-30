function dy = scalar_DDE(y, z)
    lambda = - pi / 2;
    mu = -1;
    dy = [lambda*y + mu*z];
end