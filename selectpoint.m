function point = selectpoint(choices,perm,Si,sicount)
    
    sum=0;
    vk=0;
    for i=1:length(choices)
        sum = sum +choices(i);
    end
    
    if sum == 0
        point = randi([1,6],1);
    else
        for i=1:6
            if i ~= Si(sicount)
                v(i) = choices(i)/sum;
                cc(i) = rand()*v(i) - 0.03*v(i);
                if cc(i) > vk
                    vk = cc(i);
                    pk = i;
                end
            else
                cc(i) = 0;
            end
        end
        point=pk;
    
    end
        
end