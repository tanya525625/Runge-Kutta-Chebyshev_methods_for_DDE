function z = sustainability_area(s)
    syms z;
    S = solve(abs(RKC_sustainability_area(z, s)) <= 1, z, 'ReturnConditions', true);
    z = S.conditions;
end

function R = RKC_sustainability_area(z, s)
    R = Chebyshev_polynomial(1 + z/(s*s), s);
end
