function [Si,Scost] = PSC(pheromone,posx,posy,alfa,beta)
    perm = 1;
    count =0;
    Scost = 1*ones(6);
    Si=[perm,perm];
    
    sicount=1;
    
    while count < 2    
        vecchoices = choice(pheromone,posx,posy,alfa,beta,perm);
        point = selectpoint(vecchoices,perm,Si,sicount);
        new = point;
        
        Si = [Si, new];
        Scost(perm,new) = Scost(perm,new)+ cost2(posx(perm),posx(new),posy(perm),posy(new));
                
        perm=new;
    
        if posx(perm) == 700 && posy(perm) == 700 && count == 0
            count = count+1;
        end
    
        if posx(perm) == 45 && posy(perm) == 45 && count == 1
            count = count+1;
        end
        
        
        sicount = sicount+1;      
    end
end