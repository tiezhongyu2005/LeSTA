function [State,fState,BestArchive] = Best_learning(funfcn,State,fState,SN,SE,Range,BestArchive)
[oldfBest,index1] = min(fState);
oldBest = State(index1,:);

for i = 1:SN
    X  = op_learning_from_best(State(i,:),oldBest,State,SN,SE);
    X = boundConstraint (X, Range(1,:), Range(2,:));
    [newx,newfx] = selection(funfcn,X);
    if newfx < fState(i)
        State(i,:) = newx;
        fState(i)  = newfx;
    end
end
[newfBest,index] = min(fState);
newBest = State(index,:);
if newfBest < oldfBest
    BestArchive = update_BestArchive(newBest,BestArchive);
end
end

function X = op_learning_from_best(x,Best,State,SN,SE)
n = length(Best);
idx = ceil(SN*rand(SE, 1));
xr = State(idx, :);
eta  = normrnd(0, 1, SE, 1);
zeta = normrnd(0, 1, SE, 1);
X = Best + eta.*(x - Best) + zeta.*(xr - Best);
%crossover
repx = repmat(x,SE,1);
Cr = rand;
R = rand(SE,n);
Idx = R < Cr;
X(Idx) = repx(Idx);
end
