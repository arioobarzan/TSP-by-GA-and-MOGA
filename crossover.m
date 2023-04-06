function [ offspring ] = crossover( parent )

n = size(parent,1);
m = size(parent,2);
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
    %%% stage2
    AA = [A(rnd(1)+1:rnd(2)) A(1:rnd(1)) A(rnd(2)+1:end)];
    BB = [B(rnd(1)+1:rnd(2)) B(1:rnd(1)) B(rnd(2)+1:end)];
    sec3AA = AA(rnd(2)+1:end);
    sec3BB = BB(rnd(2)+1:end);
    AA1 = AA(~ismember(AA,sec3BB));
    BB1 = BB(~ismember(BB,sec3AA));
    C3 = [AA1 sec3BB];
    C4 = [BB1 sec3AA];
    %%%
    offspring(2*(i-1)+1:2*(i-1)+4,:) = [C1;C2;C3;C4];
end

end

