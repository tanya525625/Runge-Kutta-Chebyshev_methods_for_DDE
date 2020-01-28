function show_plots_for_method(timespan, y, title)
      make_plot(timespan, y, title);
%       plot(timespan, sin(timespan), '--')
%       plot(timespan, cos(timespan), '--')
%       energy = find_energy(y);
%       energy_plot_title = strcat('energy for ', 32, title);
%       make_plot(timespan, energy, energy_plot_title);   
end


function energy = find_energy(vector)
      [m, n] = size(vector);
      energy = zeros(m, n);
      for i = 1:m
          energy = energy + vector(i,:).^2;
      end
end


function make_plot(timespan, y, plot_title)
    figure('Name', plot_title);
    hold on;
    grid on;
    title(plot_title)
    plot(timespan, y)   
end
