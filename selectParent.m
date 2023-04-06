function [ parent ] = selectParent( pop , PP , n , m )

parent = zeros(n,m);
for i=1:n 
    eta = rand;
    temp = pop(PP>=eta,:);
    parent(i,:) = temp(1,:);
end

end

