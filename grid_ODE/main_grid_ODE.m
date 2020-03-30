s = 5;
koef = 0.05;
x_0 = 0;
x_n = 1;
span_start = 0;
span_end = 10;
x_count = 40;
t_count = 50;
[x, t, u, v] = SROCK_for_grid(s, koef, x_0, x_n, span_start, span_end, x_count, t_count);
make_plot_on_grid(u, v, x, t)
