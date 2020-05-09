function y = chebyshevT2(n,x)
    T1 = 1;
    if n == 0
        y = T1;
    else
        y = x;
        for i =2:n
            T0 = T1;
            T1 = y;
            y = 2 * x * T1 - T0;        
        end
    end
end