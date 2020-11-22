function y = RKC_with_inf_eta(obj, s, is_inter)
     K = zeros(obj.timespan_length-1, s+1);
     m = obj.delay / obj.h;
     
     for n = 1 : obj.timespan_length-1
        K = find_K(obj.y(:, n), s, obj, K, n, m, is_inter);
        obj.y(:, n+1) = K(n, s+1);
     end
    y = obj.y;
end


function res = find_K_in_past(obj, K, t, m, c, i, is_inter)
    if rem(obj.delay, obj.h) == 0 && not(is_inter)
        %disp('Calculated K');
        if t - m <= 0
            res = obj.history_func(obj.timespan(t)-obj.delay);
            
        else
            res = K(t-m, i);
        end
    else
        %disp('Interpolation');
        res = interpolate_K(obj,t, c, i);
    end
end


function res = interpolate_K(obj,n, c, i)
    T = obj.timespan;
    time = T(n) + c(i)*obj.h - obj.delay;
    if time <= obj.timespan(1)
        res = obj.history_func(time);
    else  
        next_t_ind = find(T > time, 1);
        prev_t_ind = next_t_ind - 1;
        next_t = obj.timespan(next_t_ind);
        prev_t = obj.timespan(prev_t_ind);
        yn = obj.y(prev_t_ind);
        ynn = obj.y(next_t_ind);
        res = interpolation(time, prev_t, next_t, yn, ynn);
    end
end

function K = find_K(y_n, s, obj, K, t, m, is_inter)
    K(t, 1) = y_n;
    c = zeros(1, s+1);
    K(t, 2) = y_n;

    for i = 3:s+1
        delayed_K_i = find_K_in_past(obj, K, t, m, c, i-1, is_inter);
        K(t, i) = obj.h * obj.func(K(t, i-1), delayed_K_i)/2 + y_n;
    end
end
