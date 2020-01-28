function y = first_order_RKC_method_for_ODEs(obj, s)
     y = obj.y;
     for n=1:obj.timespan_length-1
        K = find_K(y(:, n), s, obj);
        y(:, n+1) = K(:, s);
    end
end


function K = find_K(y_n, s, obj)
    K = zeros(2, s);
    K(:, 1) = y_n;
    K(:, 2) = y_n + obj.h / (s * s) * obj.func(K(:, 1));
    for i = 3:s
        K(:, i) = 2 * obj.h / (s * s) * obj.func(K(:, i-1)) + 2 * K(:, i-1) - K(:, i-2);
    end
end