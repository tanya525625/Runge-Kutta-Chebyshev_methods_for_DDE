function dy = dpde_history_func(t, x)
    x_count = length(x);
    dy = zeros(1, x_count);
    dy(1, :) = sin(t);
end