function dy = ODE(y, i)
    % dy = [-y(2, 1); y(1, 1)];
    a = 4;
    h = 1/(len(y)+1);
    dy = [1 +  y(1, i)*y(1, i)*y(2, i) - 4*y(1, i) + a/(h*h) * y(1, i-1)-2*(1, i-1)+y(1,); ];
end