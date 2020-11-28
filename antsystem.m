clc
clear all
close all

population = 30;
rho = 0.5; %forgetting factor
alfa = 1; % history coefficient
beta = 2.5; %heuristica

%initial considerations
pheromone=0;

for i =1:population
    posx(i) = 45;
    posy(i) = 45;
end

posxperm=[45,100,500,500,650,700];
posyperm=[45,500,100,800,500,700];

%permutation
for i=1:6
    for j=1:6
        if i ~= j
            Ppermcost(i,j) = cost2(posxperm(i),posxperm(j),posyperm(i),posyperm(j));
            pheromone(i,j) = 1;
        else
            Ppermcost(i,j) = 100;
            pheromone(i,j) = 1;
        end
    end
end
j=1;

%Heuristic solution
count = 0;
cost = 0;
i=1;
while count<2
    j = randi([1,6],1);
    posx = posxperm(j);
    posy = posyperm(j);
    
    cost = cost + Ppermcost(i,j);
    
    if posx == 700 && posy == 700 && count == 0
        count = count+1;
    end
    
    if posx == 45 && posy == 45 && count == 1
        count = count+1;
    end
    i=j;
end


%search ants
k=1;
decayfactor=0.5;
while k<30;
   candidates = {};
   
   for m=1:population
       
        [Si,S]=PSC(pheromone,posxperm,posyperm,alfa,beta);
        
        Ssum=0;
        for i = 1:6
            for j=1:6
                Ssum = Ssum + S(i,j);
                if S(i,j) == 1
                    S(i,j)=10^15;
                end
            end
        end

        if Ssum<cost
            cost = Ssum;
            Pbest = Si;
            bestcandidate = m;
        end
        candidates{end+1} = {Si,S};
   end
    
        pheromone = decaypheromone(pheromone,decayfactor);
        pheromone = updatepheromone(pheromone,candidates);
  
    k=k+1;
end
Pbest(2:end)
cost

canvasx =[0:1:1000];
canvasy =[0:1:1000];
objectx = [-50:1:50];
objecty = [-150:3:150];

plot(posx,posy,'.b','MarkerSize',10);
hold on
plot(450+objectx, 300*ones(length(objectx)), 450+objectx, 600*ones(length(objectx)));
plot(400*ones(length(objecty)), 450+objecty, 500*ones(length(objecty)), 450+objecty);
plot(canvasx,0);
plot(0,canvasy);
plot(500,100,'.r','MarkerSize',15);
plot(650,500,'.r','MarkerSize',15);
plot(100,500,'.r','MarkerSize',15);
plot(500,800,'.r','MarkerSize',15);
plot(700,700,'.b','MarkerSize',20);

