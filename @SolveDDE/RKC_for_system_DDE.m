function y = RKC_for_scalar_DDE(obj, s, koef, is_inter)
     K = zeros(obj.timespan_length-1, s+1);
     K(:,:,2) = zeros(obj.timespan_length-1, s+1);
     m = obj.delay / obj.h;
     w_0 = 1 + koef / (s * s);
     if koef == 0
         w_1 = 1 / (s * s);
     else
         w_1 = chebyshevT2(s, w_0) / (s * (chebyshevT2(s-1, w_0) -  w_0 *chebyshevT2(s, w_0))) * (1 - w_0^2);
     end 
     
     for n = 1 : obj.timespan_length-1
        K = find_K(obj.y(:, n), s, obj, K, n, m, w_0, w_1, is_inter);
        obj.y(:, n+1) = K(n, s+1, :);
     end
    y = obj.y;
end


function res = find_K_in_past(obj, K, t, m, c, i, is_inter)
    if rem(obj.delay, obj.h) == 0 && not(is_inter)
        %disp('Calculated K');
        if t - m <= 0
            res = obj.history_func(obj.timespan(t)+c(i+1)*obj.h-obj.delay);
        else
            res = K(t-m, i, :);
        end
    else
        %disp('Interpolation');
        res = interpolate_K(obj,t, c, i);
    end
end


function res = interpolate_K(obj, n, c, i)
    T = obj.timespan;
    time = T(n) + c(i)*obj.h - obj.delay;
    if time <= obj.timespan(1)
        res = obj.history_func(time);
    else  
        next_t_ind = find(T > time, 1);
        prev_t_ind = next_t_ind - 1;
        next_t = obj.timespan(next_t_ind);
        prev_t = obj.timespan(prev_t_ind);
        yn = obj.y(:, prev_t_ind);
        ynn = obj.y(:, next_t_ind);
        res = transpose(interpolation(time, prev_t, next_t, yn, ynn));
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
