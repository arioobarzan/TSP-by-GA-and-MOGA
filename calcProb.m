function [ PP ] = calcProb( fitness , n )

P = zeros(n,1);
total = sum(fitness);
for i=1:n
    P(i) = sum(fitness(i))/total;
end
PP = zeros(n,1);
for i=1:n
    PP(i) = sum(P(1:i));
end

end

