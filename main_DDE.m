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
s = 2;
koef = 0.15;
lambda = 0.2;
is_inter = 0;
mu = 0;

% создание объекта класса для решения ДУЗА 
diffEq1 = SolveDDE(span_start, span_end, count, t_retarded,...
                   approx_init, args_count,...
                   delayed_func_, history_func_);
                    
method = 'RKC for scalar equation: ';
title = strcat(method, 32, 'N =', 32, num2str(count), ', s =', 32, num2str(s),... 
        ', h =', 32, num2str(h), ', lambda =', 32, num2str(lambda), ', mu =', 32, num2str(mu));

% нахождение численного решения
% dy1 = diffEq1.RKC_for_scalar_DDE(s, koef, is_inter);
dy2 = diffEq1.second_RKC_for_scalar_DDE(s, koef, is_inter);
% построение графиков численного решения
show_plots_for_method(diffEq1.timespan, dy2, title)

% s = 5;
% w_0 = 0.05;
% % f = @(w_0)chebyshevT2(s, w_0);
% syms x
% pr1 = diff(chebyshevT2(s, x));
% pr2 = diff(pr1)
% % pr1 = subs(pr1, x, w_0)