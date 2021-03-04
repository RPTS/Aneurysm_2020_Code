function [x_max,x_integration,x_mean,x_absmean,x_std,x_variation] = Fstatistics1(x,location)

x_max = max(abs(x));            % mm
x_integration = trapz(location,x);  % mm^2 (uniform spacing, change?)
x_mean = mean(x);          % mm
x_absmean = mean(abs(x));          % mm
x_std = std(x);                 % -
x_variation = sum(abs(diff(x)))/length(diff(x));   % -
