function y = ImplEuler(obj)
    y = obj.y;
    for n=1:length(y)-1
        z = find_delayed_t(obj, y, n+1);
        fun = @(x)implFunc(y(:, n), x, obj, z);
        y(:, n+1) = fsolve(fun, y(:, n));
    end
end

function delta = implFunc(y, ynn, obj, z)
    delta = y + obj.h*obj.find_delayed_t(ynn, z) - ynn;
end