%% init
clear all;
clc;
file= fopen('data/burma14.tsp');
filedata = textscan(file,'%f %f %f');
X=[filedata{1} filedata{2} filedata{3}];

%% parametrs
m=size(X,1); %number of cities
n=100; %pop size
itrNum = 1000; %number of iterations
L = zeros(size(X,1),size(X,1)); %path length matrix
for i=1:size(L,1)
   for j=1:size(L,2)
      L(i,j) = sqrt((X(i,2)-X(j,2))^2+(X(i,3)-X(j,3))^2);
   end
end
f1 = @(i,beta) beta*((1-beta)^(i-1));
f2 = @(i,n) (n-i+1)/n;
beta=0.2;
delta=0.3;
q=5;
k=5;
%% algorithm starting
avg = zeros(k,3);
for run=1:k
    avg(run,1) = cputime;
    %%% initialization
    pop = zeros(n,m);
    popLength = zeros(n,1);
    offspringLength = zeros(2*n,1);
    for i=1:n
        pop(i,1:m) = randperm(m);
    end
    best = inf;
    bestItr = 0;
for itr = 1:itrNum
    popLength = zeros(n,1);
    %%% sort members in ascending order
    pop1 = [pop pop(:,1)];
    for i=1:n
       for j=1:m
          popLength(i) = popLength(i) + L(pop1(i,j),pop1(i,j+1)); 
       end
    end
    [popLength, index] = sort(popLength);
    pop = pop(index,:);
    elitist = pop(1:q,:);
    
    %%%calculate fitness
    fitness = zeros(n,1);
    if(mod(itr,5)==0)
        for i=1:n   
            fitness(i) = f1(i,beta);            
        end
    else
        for i=1:n
            fitness(i) = f2(i,n);
        end   
    end
    
    %%% calculate probabilities
    P = zeros(n,1);
    total = sum(fitness);
    for i=1:n
        P(i) = (fitness(i))/total;
    end
    PP = zeros(n,1);
    for i=1:n
        PP(i) = sum(P(1:i));
    end
    
    %%% parent selection(each 2row for one crossover)
    parent = zeros(n,m);
    for i=1:n 
        eta = rand;
        temp = pop(PP>=eta,:);
        parent(i,:) = temp(1,:);
    end
%     for i=1:n 
%         rnd = randi(n,6,1);
%         tournament = pop(rnd,:);
%         [tournament , index1] = mySort(tournament,L);
%         parent(i,:) = tournament(1,:);
%     end    
    %%% crossover
    offspring = zeros(2*n,m);
    for i=1:2:n
        rnd = randi(m-1,1,2);
        rnd = sort(rnd);
        A = parent(i,:);
        B = parent(i+1,:);
        C1 = zeros(1,size(A,2));
        C2 = zeros(1,size(A,2));
        C3 = zeros(1,size(A,2));
        C4 = zeros(1,size(A,2));
        midA = A(rnd(1)+1:rnd(2));
        midB = B(rnd(1)+1:rnd(2));
        %%% stage1
        C1(rnd(1)+1:rnd(2)) = A(rnd(1)+1:rnd(2));
        C2(rnd(1)+1:rnd(2)) = B(rnd(1)+1:rnd(2));
        A1 = [A(rnd(2)+1:end) A(1:rnd(1)) A(rnd(1)+1:rnd(2))];      
        B1 = [B(rnd(2)+1:end) B(1:rnd(1)) B(rnd(1)+1:rnd(2))];
        A2 = A1(~ismember(A1,midB));
        B2 = B1(~ismember(B1,midA));   
        C1(rnd(2)+1:m) = B2(1:(m-rnd(2)));
        C1(1:rnd(1)) = B2((m-rnd(2)+1:end));
        C2(rnd(2)+1:m) = A2(1:(m-rnd(2)));
        C2(1:rnd(1)) = A2((m-rnd(2)+1:end)); 
%         if (rand<.5)
%             if(isequal(C1,C2))
%                C1 = randperm(m);
%                C2 = randperm(m);
%             end
%         end
        %%% stage2
        AA = [A(rnd(1)+1:rnd(2)) A(1:rnd(1)) A(rnd(2)+1:end)];
        BB = [B(rnd(1)+1:rnd(2)) B(1:rnd(1)) B(rnd(2)+1:end)];
        sec3AA = AA(rnd(2)+1:end);
        sec3BB = BB(rnd(2)+1:end);
        AA1 = AA(~ismember(AA,sec3BB));
        BB1 = BB(~ismember(BB,sec3AA));
        C3 = [AA1 sec3BB];
        C4 = [BB1 sec3AA];
%         if (rand<.5)
%             if(isequal(C3,C4))
%                C3 = randperm(m);
%                C4 = randperm(m);
%             end
%         end        
        %%%
        offspring(2*(i-1)+1:2*(i-1)+4,:) = [C1;C2;C3;C4];
    end
    %%% elitism
    offspringLength = zeros(2*n,1);
    offspring1 = [offspring offspring(:,1)];
    for i=1:n
       for j=1:m
          offspringLength(i) = offspringLength(i) + L(offspring1(i,j),offspring1(i,j+1)); 
       end
    end
    [offspringLength, index] = sort(offspringLength);
    offspring1 = offspring1(index,:);
    offspring1 = offspring1(:,1:end-1);
    elitist = offspring1(1:q,:);
    offspringLength = zeros(2*n+q,1);
    
    %%% mutation
    Pm = rand(2*n,1);
    for i=1:2*n
       if(Pm(i)<=delta)
          rnd = randi(m-1,1,2);
          offspring(i,rnd(1)+1:rnd(2)) = offspring(i,rnd(2):-1:rnd(1)+1);
%           rnd = [randi(size(rnd,2)) randi(m)];
%           temp = offspring(i,rnd(2));
%           offspring(i,rnd(2)) = offspring(i,rnd(1));
%           offspring(i,rnd(1)) = temp;
       end
    end
       
    %%% apply elitism
    offspring = [offspring;elitist];
    offspring1 = [offspring offspring(:,1)];

    %%% survival selection
        %%% sort members in ascending order
    for i=1:2*n+q
       for j=1:m
          offspringLength(i) = offspringLength(i) + L(offspring1(i,j),offspring1(i,j+1)); 
       end
    end
    [offspringLength, index] = sort(offspringLength);
    if(round(offspringLength(1),4)<31)
       best = offspringLength(1,:);
       bestItr = itr;
       break;
    end
    if(round(offspringLength(1),2)<round(best,2))
       best = offspringLength(1,:);
       bestItr = itr; 
    end
    offspring = offspring(index,:);
    pop = offspring(1:n,:);
%     pop(n-q+1:end,:) = elitist;
    itr
    offspringLength(1,:)
end
avg(run,3)=best;
avg(run,1) = cputime - avg(run,1);
avg(run,2) = bestItr;
run;
end
avg
offspringLength(1,:)