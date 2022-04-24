function u_new = dpde(u, x, z)
    global r k
    x_count = length(x);
    delta = 1 / (x_count);
    u_new = zeros(1, x_count);
    for i=2:x_count-1
        u_new(i) = k/(delta^2)*(u(i-1)-2*u(i)+u(i+1)) + r/(delta^2)*(z(i-1)-2*z(i)+z(i+1)); 
    end 
end
