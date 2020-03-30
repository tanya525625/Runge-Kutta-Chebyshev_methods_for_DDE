function y = ROCK_for_scalar_DDE(obj, s, koef)
     y = obj.y;
     for n = 1 : obj.timespan_length-1
        z = find_delayed_t(obj, y, n); 
        K = find_K(y(:, n), z, s, obj, koef);
        y(:, n+1) = K(:, s);
    end
end


function K = find_K(y_n, z_n, s, obj, n)
    K = zeros(obj.args_count, s+1);
    K(:, 1) = y_n;
    
    w_0 = 1 + n / (s * s);
    w_1 = chebyshevT(s, w_0);
    
    K(:, 2) = y_n + obj.h * w_1 / w_0 * obj.func(K(:, 1), z_n);

    for i = 2:s
        K(:, i+1) = 2 * chebyshevT(i-1, w_0) / chebyshevT(i, w_0) * ...
            (obj.h * w_1 * obj.func(K(:, i-1), z_n) + w_0 * K(:, i)) - chebyshevT(i-2, w_0) / chebyshevT(i, w_0) * K(:, i-1);
    end
end
