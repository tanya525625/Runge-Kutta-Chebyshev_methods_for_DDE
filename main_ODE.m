span_start = 0;
span_end = 3;
count = 500;
approx_init_1 = 1;
approx_init_2 = 0;
investigated_func = @ODE;
s = 5;


% ODE = SolveODE(span_start, span_end, count, approx_init_1,... 
%                approx_init_2, investigated_func);
%             
% dy_ODE = ODE.first_order_RKC_method_for_ODEs(s);
% show_plots_for_method(ODE.timespan, dy_ODE, 'First order RKC method for ODEs')

% dy_SROCK = ODE.SROCK_for_ODE(s, 0);
% show_plots_for_method(ODE.timespan, dy_SROCK, 'SROCK for ODE')
          
% s = 2;
% segment = [-12 0 -5 5];
% area = sustainability_area(s, segment);


s = 50;
koef = 0.05;
x_0 = 0;
x_n = 1;
span_start = 0;
span_end = 10;
x_count = 40;
t_count = 50;
[x, t, u, v] = SROCK_for_grid(s, koef, x_0, x_n, span_start, span_end, x_count, t_count);
u