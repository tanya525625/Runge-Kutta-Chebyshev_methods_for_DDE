span_start = 0;
span_end = 10;
count = 500;
approx_init_1 = 1;
approx_init_2 = 0;
investigated_func = @ODE;
s = 5;


ODE = SolveODE(span_start, span_end, count, approx_init_1,... 
               approx_init_2, investigated_func);
%            
% dy_ODE = ODE.first_order_RKC_method_for_ODEs(s);
% show_plots_for_method(ODE.timespan, dy_ODE, 'First order RKC method for ODEs')

dy_SROCK = ODE.SROCK_for_ODE(s, 0);
show_plots_for_method(ODE.timespan, dy_SROCK, 'SROCK for ODE')
          