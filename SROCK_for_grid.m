function [x, timespan, u, v] = SROCK_for_grid(s, koef, x_0, x_n, span_start, span_end, x_count, t_count)
    h_t = (span_end - span_start) / t_count;
    h_x = (x_n - x_0) / (x_count);
    timespan = span_start : h_t : span_end;
    u = zeros(t_count, x_count+1);
    v = zeros(t_count, x_count+1);
    x = x_0:h_x:x_n;
    [u(1, :), v(1, :)] = diffusion_equations(1, u, v, x);
     
    for t=2:t_count
        [K_u, K_v] = find_K(u(t, :), v(t, :), s, koef, h_t, t, x);
        u(t+1, :) = K_u(s+1, :);
        v(t+1, :) = K_v(s+1, :);
    end
end


function [K_u, K_v] = find_K(u_n, v_n, s, n, h, t, x)
    K_u = zeros(s, length(u_n));
    K_v = zeros(s, length(v_n));
    
    w_0 = 1 + n / (s * s);
    w_1 = Chebyshev_polynomial(w_0, s);
    
    K_u(1, :) = u_n;
    K_v(1, :) = v_n;
    [K_1_u_func, K_1_v_func] = diffusion_equations(t, K_u(1, :), K_v(1, :), x);
    K_u(2, :) = u_n + h * w_1 / w_0 * K_1_u_func;
    K_v(2, :) = v_n + h * w_1 / w_0 * K_1_v_func;
    
    for i = 3:s+1
        [K_i_u_func, K_i_v_func] = diffusion_equations(t, K_u(i-1, :), K_v(i-1, :), x);
        K_u(i, :) = 2 * chebyshevT(i-1, w_0) / chebyshevT(i, w_0) * ...
            (h * w_1 * K_i_u_func + w_0 * K_u(i-1, :)) - chebyshevT(i-2, w_0) / chebyshevT(i, w_0) * K_u(i-1, :);
        K_v(i, :) = 2 * chebyshevT(i-1, w_0) / chebyshevT(i, w_0) * ...
            (h * w_1 * K_i_v_func + w_0 * K_v(i-1, :)) -  chebyshevT(i-2, w_0) /  chebyshevT(i, w_0) * K_v(i-1, :);
    end
end
