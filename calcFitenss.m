function [ fitness ] = calcFitenss( itr , beta , n )

f1 = @(i,beta) beta*((1-beta)^(i-1));
f2 = @(i,n) (n-i+1)/n;
fitness = zeros(n,1);
if(mod(itr,2)==0)
    for i=1:n
        fitness(i) = f2(i,n);
    end
else
    for i=1:n
        fitness(i) = f1(i,beta);
    end   
end

end

