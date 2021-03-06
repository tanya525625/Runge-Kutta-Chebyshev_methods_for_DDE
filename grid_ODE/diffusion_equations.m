function [u_new, v_new] = diffusion_equations(u, v, x)
    x_count = length(x);
    delta = 1 / (x_count);
    u_new = zeros(1, x_count);
    v_new = zeros(1, x_count);
    alpha = 1 / 50;
    
    for i=2:x_count-1
        u_new(i) = 1 + (u(i)^2*v(i)) - 4*u(i) + alpha/(delta^2)*(u(i-1)-2*u(i)+u(i+1)); 
        v_new(i) = 3*u(i) - (u(i)^2)*v(i) + alpha/(delta^2)*(v(i-1)-2*v(i)+v(i+1)); 
    end 
end
