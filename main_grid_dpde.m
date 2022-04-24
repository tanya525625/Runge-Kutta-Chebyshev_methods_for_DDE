global r k 
r = -20;
k = 0;

span_start = 0; 
approx_init = 0; 
x_0 = 0;
x_n = pi;
x_count = 30;
history_func_ = @dpde_history_func;
delayed_func_ = @dpde;
t_retarded = pi; 
args_count = 1; 
h = 1;
count = 100; 
span_end = h * count; 
s = 20; 
koef = 1; 
h_x = (x_n - x_0) / (x_count+1);
x = x_0:h_x:x_n;


diffEq1 = SolveDDE(span_start, span_end, count, t_retarded,...
                   approx_init, args_count, delayed_func_, ...
                   history_func_);
                    
method = 'RKC for delay partial equation: '; 
title = 'Numerical solution';

dy1 = diffEq1.RKC_for_DPDE(s, koef, x_0, x_n, x_count); 

make_plot_on_grid(dy1, x, diffEq1.timespan)

