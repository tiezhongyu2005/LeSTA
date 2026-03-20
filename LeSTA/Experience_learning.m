function [State,fState,BestArchive] = Experience_learning(funfcn,State,fState,SE,Range,BestArchive)
[oldfBest,index1] = min(fState);
oldBest = State(index1,:);

X  = op_learning_from_experience(oldBest,BestArchive,SE);
X = boundConstraint (X, Range(1,:), Range(2,:));
F = fitness(funfcn,X);
[newfBest,index2] = min(F);
newBest = X(index2,:);
if newfBest < oldfBest
    State(index1,:) = newBest;
    fState(index1,:) = newfBest;
    BestArchive = update_BestArchive(newBest,BestArchive);
end
end

function State = op_learning_from_experience(Best,BestArchive,SE)
n = length(Best);
index = randi([1,size(BestArchive,1)],SE,1);
State = repmat(Best,SE,1) + unifrnd(-1,1,SE,1).*(repmat(Best,SE,1) - BestArchive(index,:));
%crossover
repBest = repmat(Best,SE,1);
Cr = rand;
R = rand(SE,n);
Idx = R < Cr;
State(Idx) = repBest(Idx);
end
