function [State,fState,BestArchive] = Self_learning(funfcn,State,fState,SE,Range,BestArchive,delta,alpha)
 
[oldfBest,index1] = min(fState);
oldBest = State(index1,:);
X  = [op_axes(oldBest,SE,delta);op_rotate(oldBest,SE,alpha)];
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

function State  = op_axes(Best,SE,delta)
n = length(Best);
State = repmat(Best,SE,1) +  delta*sparse(1:SE,randi([1,n],1,SE),randn(1,SE),SE,n).*ones(SE,n);
end

function y=op_rotate(Best,SE,alpha)
n = length(Best);
y = repmat(Best',1,SE) + alpha*(1/n/(norm(Best)+eps))*reshape(unifrnd(-1,1,SE*n,n)*Best',n,SE);
y = y';
end



