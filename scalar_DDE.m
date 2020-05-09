function dy = scalar_DDE(y, z)
global lambda mu;
    dy = lambda*y + mu*z;
end