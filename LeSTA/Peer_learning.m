function [State,fState,BestArchive] = Peer_learning(funfcn,State,fState,SN,Range,BestArchive)
[oldfBest,index1] = min(fState);

Idx = randperm(SN);
newState = op_learning_from_peers(State(Idx(1),:),State(Idx(2:end),:));
newState = boundConstraint (newState, Range(1,:), Range(2,:));
[x,f] = selection(funfcn,newState);
if f < fState(Idx(1),:)
    State(Idx(1),:)  = x;
    fState(Idx(1),:) = f;
end

[newfBest,index2] = min(fState);
newBest = State(index2,:);
if newfBest < oldfBest
    State(index1,:) = newBest;
    fState(index1,:) = newfBest;
    BestArchive = update_BestArchive(newBest,BestArchive);
end

end

function State = op_learning_from_peers(x,State)
[SN,n] = size(State);
eta  = normrnd(0, 1, SN, 1);
newState = x + eta.*(State - x);

%crossover
Cr = rand;
R = rand(SN,n);
Idx = R < Cr;
State(Idx) = newState(Idx);
end
