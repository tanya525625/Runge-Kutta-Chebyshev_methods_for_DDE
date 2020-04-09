span_start = 0;
span_end = 20;
count = 1000;
approx_init = 1;
history_func = @history_func;
delayed_func = @scalar_DDE;
t_retarded = 1;
args_count = 1;


diffEq1 = SolveDDE(span_start, span_end, count, t_retarded,...
                   approx_init, args_count,...
                   delayed_func, history_func);
                    
s = 2;
koef = 0;
lambda = -100;
is_inter = 0;
mu = 2;
h = (span_end - span_start) / count

method = 'Rock for scalar equation: ';
title = strcat(method, 32, 'N =', 32, num2str(count), ', s =', 32, num2str(s),... 
        ', h =', 32, num2str(h), ', lambda =', 32, num2str(lambda), ', mu =', 32, num2str(mu));
                  
dy1 = diffEq1.ROCK_for_scalar_DDE(s, koef, is_inter);
show_plots_for_method(diffEq1.timespan, dy1, title)

