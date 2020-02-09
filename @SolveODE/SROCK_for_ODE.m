function y = SROCK_for_ODE(obj, s, koef)
     y = obj.y;
     for n=1:obj.timespan_length-1
        K = find_K(y(:, n), s, obj, koef);
        y(:, n+1) = K(:, s);
    end
end


function K = find_K(y_n, s, obj, n)
    K = zeros(2, s);
    K(:, 1) = y_n;
    w_0 = 1 + n / (s * s);
    
    w_1 = Chebyshev_polynomial(w_0, s);
    K(:, 2) = y_n + obj.h * w_1 / w_0 * obj.func(K(:, 1));
    for i = 3:s
        K(:, i) = 2 * Chebyshev_polynomial(w_0, i - 1) / Chebyshev_polynomial(w_0, i) * ...
            (obj.h * w_1 * obj.func(K(:, i-1)) + w_0 * K(:, i-1)) - Chebyshev_polynomial(w_0, i - 2) / Chebyshev_polynomial(w_0, i) * K(:, i-2);
    end
end
