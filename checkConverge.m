function [ converged ] = checkConverge(offspringLength , solution )

if(round(offspringLength(1),4)<=solution)
   converged = true;
else
    converged = false;
end

end

