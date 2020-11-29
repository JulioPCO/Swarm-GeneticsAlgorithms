function population = createbees(nbees)
    population = [];
    for i=1:nbees
       population = [population; [1000*rand(),1000*rand()]]; 
    end
end