function choices = choice(pheromone,posx,posy,alfa,beta,perm)
    choices = [];
    for i=1:6
        if i ~= perm 
            Prob = (pheromone(perm,i)^alfa) * (1/cost2(posx(perm),posx(i),posy(perm),posy(i)))^beta;
            choices(i) =  Prob; 
        else
            choices(i) =  0;
        end
    end
end