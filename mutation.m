function [ offspring ] = mutation( offspring ,delta,mutationMode)

Pm = rand(size(offspring,1),1);
m = size(offspring,2);
for i=1:size(offspring,1)
   if(Pm(i)<=delta)
      rnd = randi(m-1,1,2);
      offspring(i,rnd(1)+1:rnd(2)) = offspring(i,rnd(2):-1:rnd(1)+1);
      if(mutationMode==1)
          rnd = [randi(size(rnd,2)) randi(m)];
          temp = offspring(i,rnd(2));
          offspring(i,rnd(2)) = offspring(i,rnd(1));
          offspring(i,rnd(1)) = temp; 
      end
   end
end

end

