function [x, timespan, u, v] = SROCK_for_grid( ...
    s, koef, x_0, x_n, span_start, span_end, x_count, t_count)
    h_t = (span_end - span_start) / t_count;
    h_x = (x_n - x_0) / (x_count+1);
    timespan = span_start : h_t : span_end;
    u = zeros(t_count, x_count+2);
    x = x_0:h_x:x_n;
    % Boundary conditions
    u(:,1) = 1;
    u(:,x_count+1) = 1;
    % Initial conditions
    u(1, :) = 1 + sin(2*pi*x);
     
    for t = 2 : t_count + 1
        K_u = find_K(u(t-1, :), v(t-1, :), s, koef, h_t, t, x);
        u(t, :) = K_u(s+1, :);
    end
end


function K = find_K(y_n, s, obj, K, t, m, w_0, w_1, is_inter)
    K(t, 1, :) = y_n;
    c = zeros(1, s+1);
    c(1) = 0;
    
    c(2) = w_1 / w_0;
    delayed_K_1 = find_K_in_past(obj, K, t, m, c, 1, is_inter);
    K(t, 2, :) = transpose(y_n) + obj.h * w_1 / w_0 * obj.func(K(t, 1, :), delayed_K_1);

    for i = 3:s+1
        c(i) = 2 * chebyshevT2(i-1, w_0) / chebyshevT2(i, w_0) * (w_1 + w_0*c(i-1)) ...
            - chebyshevT2(i-2, w_0) / chebyshevT2(i, w_0) * c(i-2);
        delayed_K_i = find_K_in_past(obj, K, t, m, c, i-1, is_inter);
        K(t, i, :) = 2 * chebyshevT2(i-1, w_0) / chebyshevT2(i, w_0) * ...
            (transpose(obj.h * w_1 * obj.func(K(t, i-1, :), delayed_K_i)) + ... 
             permute(w_0 * K(t, i-1, :), [3, 1, 2])) ...
             - chebyshevT2(i-2, w_0) / chebyshevT2(i, w_0) * permute(K(t, i-2, :), [3, 1, 2]);
    end
end
