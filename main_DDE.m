span_start = 0;
span_end = 10;
count = 103;
approx_init = 1;
history_func = @history_func;
delayed_func = @scalar_DDE;
inv_func2 = @retarded_func_scalar;
t_retarded = 1;
args_count = 1;


diffEq1 = SolveDDE(span_start, span_end, count, t_retarded,...
                   approx_init, args_count,...
                   delayed_func, history_func);
                    
s = 5;
koef = 0.05;
                  
dy1 = diffEq1.ROCK_for_scalar_DDE(s, koef);
show_plots_for_method(diffEq1.timespan, dy1, 'Rock for scalar equation')
