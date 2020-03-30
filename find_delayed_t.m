function z = find_delayed_t(obj, y, n)
    T = obj.timespan;
    z = zeros(obj.args_count, length(obj.delay));
    delay = T(n) - obj.delay;

    %TO DO: delays cycle
    delay_number = 1;
    delay_func_ind = delay_number;
    if delay <= obj.timespan(1)
       z(:, delay_func_ind) = obj.history_func(delay);
    else
        if rem(obj.delay, obj.h) == 0
            t_ind = find(T > delay, 1);
            t_ind = t_ind - 1;
            z(:, delay_func_ind) = y(:, t_ind);
        else
            next_t_ind = find(T > delay, 1);
            prev_t_ind = next_t_ind - 1;
            next_t = obj.timespan(next_t_ind);
            prev_t = obj.timespan(prev_t_ind);
            yn = y(:, prev_t_ind);
            ynn = y(:, next_t_ind);

            z(:, delay_func_ind) = interpolation(delay, prev_t, ...
                                                 next_t, yn, ynn);
        end
    end                                       
end   