function y = RKC2_for_DPDE(obj, s, koef, x_0, x_n, x_count)
    h_x = (x_n - x_0) / (x_count+1);
    obj.y = zeros(obj.timespan_length, x_count+2);
    x = x_0:h_x:x_n;
    % Boundary conditions
    obj.y(:,1) = 0;
    obj.y(:,x_count+2) = 1;

    m = obj.delay / obj.h;
    w_0 = 1 + koef / (s * s);
    syms vari
    pr1 = diff(chebyshevT2(s, vari));
    pr2 = diff(pr1);
    pr1_val = subs(pr1, vari, w_0);
    pr2_val = subs(pr2, vari, w_0);
    w_1 = double(pr1_val / pr2_val); 
     
    for t = 2 : obj.timespan_length
        K_y = find_K(obj.y(t-1, :), s, obj, t, m, w_0, w_1, x);
        obj.y(t, :) = K_y(s+1, :);
    end
    y = obj.y;
end


function res = find_K_in_past(obj, K, t, m, c, i, x)
    res = interpolate_K(obj,t, c, i, x);
end


function res = interpolate_K(obj, n, c, i, x)
    T = obj.timespan;
    time = T(n) + c(i)*obj.h - obj.delay;
    if time <= obj.timespan(1)
        res = obj.history_func(time, x);
    else  
        next_t_ind = find(T > time, 1);
        prev_t_ind = next_t_ind - 1;
        next_t = obj.timespan(next_t_ind);
        prev_t = obj.timespan(prev_t_ind);
        yn = obj.y(prev_t_ind, :);
        ynn = obj.y(next_t_ind, :);
        res = interpolation(time, prev_t, next_t, yn, ynn);
    end
end


function K = find_K(y_n, s, obj, t, m, w_0, w_1, x)
    K = zeros(s+1, length(y_n));
    c = zeros(1, s+1);
    c(1) = 0;
    c(2) = w_1 / w_0;

    delayed_K_1 = find_K_in_past(obj, K, t, m, c, 1, x);
    
    K(1, :) = y_n;
    K(2, :) = y_n + obj.h * w_1 * b(1, w_0) * obj.func(K(1, :), x, delayed_K_1);
    
    for i = 3:s+1
        c(i) = 2 * chebyshevT2(i-1, w_0) / chebyshevT2(i, w_0) * (w_1 + w_0*c(i-1)) ...
            - chebyshevT2(i-2, w_0) / chebyshevT2(i, w_0) * c(i-2);
        delayed_K_i = find_K_in_past(obj, K, t, m, c, i-1, x);
        a_i = a(i-2, w_0);
        mu_i = 2 * b(i-1, w_0) * w_1 / b(i-2, w_0);
        nu_i = 2 * b(i-1, w_0) * w_0 / b(i-2, w_0);
        if  b(i-3, w_0) == 0
            k_i = -b(i-1, w_0);
        else
            k_i = -b(i-1, w_0) / b(i-3, w_0);
        end    
        K(i, :) = y_n + mu_i * obj.h * (obj.func(K(i-1, :), x, delayed_K_i) - ...
            a_i * obj.func(y_n, x, delayed_K_i)) ...
            + nu_i * (K(i-1, :) - y_n) + k_i * (K(i-2, :) - y_n);
    end
end

function res = b(s, w_0)
    if s < 2
        s = 2;
    end
    syms x
    pr1 = diff(chebyshevT2(s, x));
    pr2 = diff(pr1);
    pr1_val = subs(pr1, x, w_0);
    pr2_val = subs(pr2, x, w_0);
    res = double(pr2_val / (pr1_val * pr1_val));
end

function res = a(s, w_0)
    res = double(1 - b(s, w_0) * chebyshevT2(s, w_0));
end
