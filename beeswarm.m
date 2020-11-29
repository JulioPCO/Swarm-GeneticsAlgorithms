clc
clear all
close all

%bee swarm

problemsize = 1;
searchspace = 0:1000;
nbees = 30;
numsite = 3;
elitesite = 2; %Temos apenas 1 elite site, como o vetor do matlab começa do 1 é necessário colocar elitesite+1
patchsize = 10;
ebee = 7;
obee = 2;
patchsize = 40;
patchfactor = 0.95;

maxgen = 500;

rng = 'default';

population = createbees(nbees);

BBest=10^15;
mg=1;
while mg<maxgen
    Bcost=[];
    
    for i=1:nbees
       Bcost = [Bcost cost(population(i,1),population(i,2))]; 
       if Bcost(i) < BBest
          BBest = Bcost(i);
          bee=[population(i,1),population(i,2)];
       end       
    end
    
    nextgeneration = [];
    Ssites = [];
    Bcostaux = Bcost;
    
    for i=1:numsite
       [val,index] = min(Bcostaux);
       Bcostaux(index)=[];
       Ssites=[Ssites; [val,find(Bcost == val),...
           population(find(Bcost == val),1),population(find(Bcost == val),2)]];
    end
    
    for i=1:numsite
        if i<elitesite
            Recruitedbee =  ebee;
        else
            Recruitedbee =  obee;
        end
        
        Neighboor = [];
        for j=1:Recruitedbee
           Neighboor = [Neighboor; searchneighboor(Recruitedbee,Ssites(i,:),patchsize)]; 
        end
        
        [minNeigh,index] = min(Neighboor(:,1));
        nextgeneration = [nextgeneration; [minNeigh,Neighboor(index,2)],Neighboor(index,3)];
    end
    
    scout = createbees(nbees-numsite);
    population = [scout; nextgeneration(:,2:3)];        
    patchsize = patchfactor*patchsize;
    
    mg= mg+1;
end

BBest
bee