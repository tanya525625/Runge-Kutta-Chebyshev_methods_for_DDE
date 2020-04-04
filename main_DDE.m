span_start = 0;
span_end = 2;
count = 2000;
approx_init = 0;
history_func = @history_func;
delayed_func = @scalar_DDE;
t_retarded = 1;
args_count = 1;


diffEq1 = SolveDDE(span_start, span_end, count, t_retarded,...
                   approx_init, args_count,...
                   delayed_func, history_func);
                    
s = 1;
koef = 0.05;
                  
dy1 = diffEq1.ROCK_for_scalar_DDE(s, koef);
show_plots_for_method(diffEq1.timespan, dy1, 'Rock for scalar equation')
dy1
