function [x, timespan, u, v] = SROCK_for_grid(s, koef, x_0, x_n, span_start, span_end, x_count, t_count)
    h_t = (span_end - span_start) / t_count;
    h_x = (x_n - x_0) / (x_count+1);
    timespan = span_start : h_t : span_end;
    u = zeros(t_count, x_count+2);
    v = zeros(t_count, x_count+2);
    x = x_0:h_x:x_n;
    % Boundary conditions
    u(:,1) = 1;
    u(:,x_count+1) = 1;
    v(:,1) = 3;
    v(:,x_count+1) = 3;
    % Initial conditions
    u(1, :) = 1 + sin(2*pi*x);
    v(1, :) = 3;
     
    for t = 2 : t_count + 1
        [K_u, K_v] = find_K(u(t-1, :), v(t-1, :), s, koef, h_t, t, x);
        u(t, :) = K_u(s+1, :);
        v(t, :) = K_v(s+1, :);
    end
end


function [K_u, K_v] = find_K(u_n, v_n, s, n, h, t, x)
    K_u = zeros(s+1, length(u_n));
    K_v = zeros(s+1, length(v_n));
    
    w_0 = 1 + n / (s * s);
    w_1 = chebyshevT(s, w_0) / (s * (chebyshevT(s-1, w_0) - w_0 *chebyshevT(s, w_0))) * (1 - w_0^2);
    
    K_u(1, :) = u_n;
    K_v(1, :) = v_n;
    
    [K_1_u_func, K_1_v_func] = diffusion_equations(K_u(1, :), K_v(1, :), x);
    
    K_u(2, :) = u_n + h * w_1 / w_0 * K_1_u_func;
    K_v(2, :) = v_n + h * w_1 / w_0 * K_1_v_func;
    
    for i = 2:s
        [K_i_u_func, K_i_v_func] = diffusion_equations(K_u(i, :), K_v(i, :), x);
        K_u(i+1, :) = 2 * chebyshevT(i-1, w_0) / chebyshevT(i, w_0) * ...
            (h * w_1 * K_i_u_func + w_0 * K_u(i, :)) - chebyshevT(i-2, w_0) / chebyshevT(i, w_0) * K_u(i-1, :);
        K_v(i+1, :) = 2 * chebyshevT(i-1, w_0) / chebyshevT(i, w_0) * ...
            (h * w_1 * K_i_v_func + w_0 * K_v(i, :)) -  chebyshevT(i-2, w_0) /  chebyshevT(i, w_0) * K_v(i-1, :);
    end
end
