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
       function obj = SolveDDE(span_start, span_end, count, const,...
                                    approx_init, args_count,...
                                    retarded_func, history_func)
            obj.h = (span_end - span_start) / count;
            obj.approx_init = approx_init;
            obj.history_func = history_func;
            obj.func = retarded_func;
            obj.timespan = span_start:obj.h:span_end;
            obj.timespan_length = length(obj.timespan);
            obj.y = zeros(args_count, obj.timespan_length);
            obj.y(:, 1) = obj.approx_init;
            obj.delay = const;
            obj.args_count = args_count;
       end
       y = ROCK_for_scalar_DDE(obj, s, koef);
   end
end