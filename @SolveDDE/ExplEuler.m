function y = ExplEuler(obj)
    y = obj.y;

    for n=1:obj.timespan_length-1
        z = find_delayed_t(obj, y, n);
        y(:, n+1) = y(:, n) + obj.h*obj.func(y(:, n), z);
    end
end