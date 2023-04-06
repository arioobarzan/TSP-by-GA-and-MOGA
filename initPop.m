function [ pop ] = initPop( n,m )

pop = zeros(n,m);
for i=1:n
    pop(i,1:m) = randperm(m);
end

end

