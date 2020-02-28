function area = sustainability_area(s, segment)
    syms x y z
    eq = subs(RKC_sustainability_area(z, s), z, x + 1i*y);
    eq = '@(x, y)' + string(abs(eq)) + ' - 1';
    area = str2func(eq);
    fimplicit(area, segment);
end

function R = RKC_sustainability_area(z, s)
    syms z;
    R = chebyshevT(s, 1 + z/(s*s));
end
