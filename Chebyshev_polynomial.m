function T = Chebyshev_polynomial(x, degree)

    % T = cos(degree * acos(x));
    if degree == 0
        T = 1;
    elseif degree == 1
        T = x;
    else
        T = 2 * x * Chebyshev_polynomial(x, degree-1) - Chebyshev_polynomial(x, degree-2);
    end
    
end