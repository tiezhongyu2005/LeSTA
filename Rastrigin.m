function y = Rastrigin(x)
% Rastrigin function
% -5.12 <= x <= 5.12
n = length(x);
s = sum(x.^2 - 10*cos(2*pi*x));
y = 10*n + s;