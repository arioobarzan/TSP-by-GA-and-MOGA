clear all;
close all;
clc;
k=100;
avgBGA = zeros(k,3);
avgMOGA = zeros(k,4);
%%% MOGA( fileName , popSize , itrNum , q , beta , mutation prob ,solution , selectionMode , mutationMode)

%% burma14 dataset
X = readFile('burma14.tsp');
bestPath = zeros(k,size(X,1)+1);
for run=1:k
    [avgMOGA(run,1), avgMOGA(run,2), avgMOGA(run,3), bestPath(run,:) ] = MOGA(X,100,999,3,.04,.3,31,0,0);
    [avgBGA(run,1), avgBGA(run,2), avgBGA(run,3)] = BGA(X,100,999,3,.05,.05,31,0,0);
    run
end
avgMOGA = sortrows(avgMOGA,1);
avgBGA = sortrows(avgBGA,1);
result = [mean(avgMOGA(1:50,1:3));mean(avgBGA(1:50,1:3))]
%plot
bestPath = bestPath(round(bestPath(:,end),4)==30.8785,1:end-1);
bestPath = bestPath(1,:);
bestPath = [bestPath bestPath(1)]
X1 = X(bestPath',:)
plot(X1(:,2),X1(:,3))
for i=1:size(X1,1)
    text(X1(i,2),X1(i,3),sprintf('%d',X1(i,1)))
end

%% eil51 dataset
X = readFile('eil51.tsp');
bestPath = zeros(k,size(X,1)+1);
for run=1:k
    [avgMOGA(run,1), avgMOGA(run,2), avgMOGA(run,3), bestPath(run,:) ] = MOGA(X,100,999,5,.3,.3,445,0,0);
    [avgBGA(run,1), avgBGA(run,2), avgBGA(run,3)] = BGA(X,100,999,5,.3,.3,445,0,0);
    run
end
avgMOGA = sortrows(avgMOGA,1);
avgBGA = sortrows(avgBGA,1);
result = [mean(avgMOGA(1:50,:));mean(avgBGA(1:50,:))]
%plot
bestPath = bestPath(round(bestPath(:,end),4)==443,1:end-1);
bestPath = bestPath(1,:);
bestPath = [bestPath bestPath(1)]
X1 = X(bestPath',:)
plot(X1(:,2),X1(:,3))
for i=1:size(X1,1)
    text(X1(i,2),X1(i,3),sprintf('%d',X1(i,1)))
end

%% kroB100 dataset
X = readFile('kroB100.tsp');
bestPath = zeros(k,size(X,1)+1);
for run=1:k
    [avgMOGA(run,1), avgMOGA(run,2), avgMOGA(run,3), bestPath(run,:) ] = MOGA(X,100,999,10,.2,.3,22145,0,0);
    [avgBGA(run,1), avgBGA(run,2), avgBGA(run,3)] = BGA(X,100,999,10,.2,.3,22145,0,0);
    run
end
avgMOGA = sortrows(avgMOGA,1);
avgBGA = sortrows(avgBGA,1);
result = [mean(avgMOGA(1:50,:));mean(avgBGA(1:50,:))]
%plot
bestPath = bestPath(round(bestPath(:,end),4)==22145,1:end-1);
bestPath = bestPath(1,:);
bestPath = [bestPath bestPath(1)]
X1 = X(bestPath',:)
plot(X1(:,2),X1(:,3))
for i=1:size(X1,1)
    text(X1(i,2),X1(i,3),sprintf('%d',X1(i,1)))
end

%% pr1020 dataset
X = readFile('pr1002.tsp');
bestPath = zeros(k,size(X,1)+1);
for run=1:k
    [avgMOGA(run,1), avgMOGA(run,2), avgMOGA(run,3), bestPath(run,:) ] = MOGA2(X,500,999,10,.05,.3,265136,0,0);
    [avgBGA(run,1), avgBGA(run,2), avgBGA(run,3)] = BGA2(X,500,999,10,.05,.3,265,0,0);
    run
end
avgMOGA = sortrows(avgMOGA,1);
avgBGA = sortrows(avgBGA,1);
result = [mean(avgMOGA(1:5,:));mean(avgBGA(1:5,:))]
%plot
bestPath = bestPath(round(bestPath(:,end),2)==265136,1:end-1);
bestPath = bestPath(1,:);
bestPath = [bestPath bestPath(1)]
X1 = X(bestPath',:)
plot(X1(:,2),X1(:,3))
for i=1:size(X1,1)
    text(X1(i,2),X1(i,3),sprintf('%d',X1(i,1)))
end