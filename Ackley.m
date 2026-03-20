function y = Ackley(x)
% Ackley function
% -32 <= x <= 32
dim = size(x,2);
y=-20*exp(-0.2*sqrt(1/dim*sum(x.^2,2)))-exp(1/dim*sum(cos(2*pi.*x),2))+20+exp(1);
