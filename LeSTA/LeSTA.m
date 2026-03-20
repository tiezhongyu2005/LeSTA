function [Best,fBest,history] = LeSTA(funfcn,n,Range,MaxIter)
rng(sum(100*clock),'twister')

SN = 30;
SE = 10;

delta = 1;
alpha_max = 1;
alpha_min = 1e-4;
alpha = alpha_max;
fc = 2;

% initialization
State  = rand(SN,n).*repmat(Range(2,:)-Range(1,:),SN,1) + repmat(Range(1,:),SN,1);
fState = fitness(funfcn,State);
[fBest,index] = min(fState);
Best = State(index,:);

BestArchive = Best;
history = fBest;

% iterative process
for iter = 1:MaxIter
    
    if alpha < alpha_min
        alpha = alpha_max;
    end
    
    % Learning from the best
    [State,fState,BestArchive] = Best_learning(funfcn,State,fState,SN,SE,Range,BestArchive);
    
    % Learning from peers
    [State,fState,BestArchive] = Peer_learning(funfcn,State,fState,SN,Range,BestArchive);
    
    % self Learning
    [State,fState,BestArchive] = Self_learning(funfcn,State,fState,SE,Range,BestArchive,delta,alpha);

    % Learning from experience
    [State,fState,BestArchive] = Experience_learning(funfcn,State,fState,SE,Range,BestArchive);
    
    [fBest,index] = min(fState);
    Best = State(index,:);
    
    fprintf('iter=%d  ObjVal=%20.16g\n',iter, fBest);

    history = [history;fBest];
    
    alpha = alpha/fc;
end


