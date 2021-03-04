function [x_max,x_integration,x_mean,x_std,x_variation] = Fstatistics(x)

x_max = max(abs(x));            % mm
x_integration = trapz(abs(x));  % mm^2 (uniform spacing, change?)
x_mean = mean(abs(x));          % mm
x_std = std(x);                 % -
x_variation = sum(abs(diff(x)))/length(diff(x));   % -