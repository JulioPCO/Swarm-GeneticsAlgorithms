function pheromone = decaypheromone(pheromone,decayfactor)

    for i =1:6
        for j =1:6
            pheromone(i,j)= (1- decayfactor)*pheromone(i,j);
        end
    end
end