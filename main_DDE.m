global lambda mu

span_start = 0;
approx_init = 1;
history_func_ = @history_func;
delayed_func_ = @scalar_DDE;
t_retarded = 1; 
args_count = 1;
h = 0.005;
count = 100;
span_end = h * count;
s = 2;
koef = 5000;
lambda = -300;
is_inter = 0;
mu = 200;

% создание объекта класса для решения ДУЗА 
diffEq1 = SolveDDE(span_start, span_end, count, t_retarded,...
                   approx_init, args_count,...
                   delayed_func_, history_func_);
                    
method = 'RKC for scalar equation: ';
method1 = 'ExplEuler: ';
title = strcat(method, 32, 'N =', 32, num2str(count), ', s =', 32, num2str(s),... 
        ', h =', 32, num2str(h), ', lambda =', 32, num2str(lambda), ', mu =', 32, num2str(mu));
title1 = strcat(method1, 32, 'N =', 32, num2str(count), ', s =', 32, num2str(s),... 
    ', h =', 32, num2str(h), ', lambda =', 32, num2str(lambda), ', mu =', 32, num2str(mu));

% нахождение численного решения
dy1 = diffEq1.RKC_with_inf_eta(s, is_inter);
dy3 = diffEq1.ExplEuler();
% dy2 = diffEq1.second_RKC_for_scalar_DDE(s, koef, is_inter);
% построение графиков численного решения
show_plots_for_method(diffEq1.timespan, dy1, title)
show_plots_for_method(diffEq1.timespan, dy3, title1)
