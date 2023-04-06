function [ totalTime, time, best ] = BGA2( X , popSize , stopTime , q , beta , delta ,solution , selectionMode , mutationMode)
startTime = cputime;
best = inf;
%% parametrs
m=size(X,1); %number of cities
n=popSize; %pop size
L = zeros(size(X,1),size(X,1)); %path length matrix
for i=1:size(L,1)
   for j=1:size(L,2)
      L(i,j) = sqrt((X(i,2)-X(j,2))^2+(X(i,3)-X(j,3))^2);
   end
end

%% algorithm

%%% initialization
pop = initPop(n,m);
itr=0;
while (cputime-startTime<stopTime)   
    %%% First Elitism
    [ pop , ~] =  mySort(pop,L);
    elitist = elitism(pop,q);
    
    %%% Parent Selection
    parent = parentSelection( pop , itr , beta , n , m , selectionMode);
    
    %%% Crossover
    offspring = crossoverBGA(parent);
    
    %%% Second Elitism
    elitist = elitism(mySort([offspring;elitist],L),q);
    
    %%% Mutation
    offspring = mutation(offspring,delta,mutationMode);
       
    %%% Apply Elitism
    offspring = [offspring;elitist];

    %%% Survival Selection
    [offspring , offspringLength] = mySort(offspring,L);
    
    %%% Check convergence
    if(checkConverge(offspringLength,solution))
        best = offspringLength(1);
        break;
    else
        if(offspringLength(1)<best)
            best = offspringLength(1);
        end
        pop = offspring(1:n,:);
    end
    itr = itr + 1;
    offspringLength(1);
end
time = cputime - time;
totalTime = cputime-startTime;
end

