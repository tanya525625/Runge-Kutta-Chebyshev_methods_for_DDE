function make_plot_on_grid(u, x, t)
    [dim_t, dim_x] = size(u);
    figure(1)
    plot3(ones(dim_t,1) * x, t' * ones(1,dim_x), u)
end