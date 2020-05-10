global lambda mu

span_start = 0;
approx_init = 1;
history_func_ = @history_func;
delayed_func_ = @scalar_DDE;
t_retarded = 1; 
args_count = 1;
h = 1;
count = 100;
span_end = h * count;

diffEq1 = SolveDDE(span_start, span_end, count, t_retarded,...
                   approx_init, args_count,...
                   delayed_func_, history_func_);
                    
s = 2;
koef = 0;
lambda = -4;
is_inter = 1;
mu = 0;
%h = (span_end - span_start) / count

method = 'RKC for scalar equation: ';
title = strcat(method, 32, 'N =', 32, num2str(count), ', s =', 32, num2str(s),... 
        ', h =', 32, num2str(h), ', lambda =', 32, num2str(lambda), ', mu =', 32, num2str(mu));
                  
dy1 = diffEq1.RKC_for_scalar_DDE(s, koef, is_inter);
show_plots_for_method(diffEq1.timespan, dy1, title)

