function [ pop , popLength] = mySort( pop , L)
popLength = zeros(size(pop,1),1);
pop1 = [pop pop(:,1)];
for i=1:size(pop,1)
   for j=1:size(pop,2)
      popLength(i) = popLength(i) + L(pop1(i,j),pop1(i,j+1)); 
   end
end
[popLength, index] = sort(popLength);
pop = pop(index,:);

end

