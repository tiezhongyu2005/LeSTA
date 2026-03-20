clear all
clc
currentFolder = pwd;
addpath(genpath(currentFolder))

funfcn = @Rosenbrock; % objective function
n = 20; % dimension
lb = -30*ones(1,n);    % lower bound
ub = 30*ones(1,n);  % upper bound
Range = [lb;ub]; 
MaxIter = round(100*n); % maximum iterations, can be increased when necessary

tic
[Best,fBest,history] = LeSTA(funfcn,n,Range,MaxIter);
toc
fBest
semilogy(history)
legend('LeSTA')

