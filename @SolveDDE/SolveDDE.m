classdef SolveDDE
    %{
        Class for solving differential equans
    
        properties:
            approx_init: initial approximations
            y: system solution
            h: step 
            timespan: study period
            func: differential equation system
            timespan_length: count study period's segments 
            t_retarded: retarded argument
    %}
   properties
      args_count
      approx_init
      y
      h
      timespan 
      func
      retarded_func
      timespan_length
      delay
      history_func 
   end
   methods   
       function obj = SolveDDE(span_start, span_end, points_count, delay,...
                                    approx_init, args_count,...
                                    retarded_func, history_func)
            obj.h = (span_end - span_start) / points_count;
            obj.approx_init = approx_init;
            obj.history_func = history_func;
            obj.func = retarded_func;
            obj.retarded_func = retarded_func;
            obj.timespan = span_start:obj.h:span_end;
            obj.timespan_length = length(obj.timespan);
            obj.y = zeros(args_count, obj.timespan_length);
            obj.y(:, 1) = obj.approx_init;
            obj.delay = delay;
            obj.args_count = args_count;
       end
       y = RKC_for_scalar_DDE(obj, s, koef, is_inter);
       y = RKC_for_system_DDE(obj, s, koef, is_inter);
       y = second_RKC_for_scalar_DDE(obj, s, koef, is_inter);
       y = RKC_with_inf_eta(obj, s, is_inter);
       y = ExplEuler(obj);
       y = ImplEuler(obj);
       y = RKC_for_DPDE(obj, s, koef, is_inter, x_0, x_n, x_count);
       y = RKC2_for_DPDE(obj, s, koef, x_0, x_n, x_count);
   end
end