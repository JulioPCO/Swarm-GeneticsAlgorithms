function Snb = searchneighboor(neighsize,Ssite,patchsize)
    
    Neigh =[];
    for i=1:neighsize       
            v=rand();
            if v < 0.5
                x = Ssite(3)+rand()*patchsize;
                y = Ssite(4)+rand()*patchsize;
                
                if x > 1000
                    x = 1000;
                end
                
                if y > 1000
                    y = 1000;
                end
                
            else
                x = Ssite(3)-rand()*patchsize;
                y = Ssite(4)-rand()*patchsize;

                if x < 0
                    x = 0;
                end
                
                if y < 0
                    y = 0;
                end
            end
                  
      Neigh = [Neigh; [cost(x,y),x,y]];
    end

    [minnb,index] = min(Neigh(:,1));
    Snb = [minnb,Neigh(index,2),Neigh(index,3)];
end

