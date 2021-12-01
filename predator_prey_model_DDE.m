function dy = predator_prey_model_DDE(y, z)
    global lambda mu zetta eta;
    dy = zeros(1, 2);
    dy(1) = y(1) * (1 - z(1) - 0.5*y(2));
    dy(2) = y(2) * (-1 + 2 * y(1) - 4*y(2));
end