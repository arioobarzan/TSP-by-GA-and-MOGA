function [ parent ] = parentSelection( pop , itr , beta , n , m , selectionMode)
if selectionMode==0
    fitness = calcFitenss(itr,beta,n);
    PP = calcProb(fitness,n);
    parent = selectParent(pop,PP,n,m);
elseif selectionMode==1 %tournament selection 
    parent = zeros(n,m);
    for i=1:n 
        rnd = randi(n,6,1);
        tournament = pop(rnd,:);
        [tournament , ~] = mySort(tournament,L);
        parent(i,:) = tournament(1,:);
    end    
end

end

