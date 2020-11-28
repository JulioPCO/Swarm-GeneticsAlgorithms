clc
clear all
close all

population = 30;
pgbestx = 45;
pgbesty = 60;
centro = 45; %centro da circunferencia do enxame 



for i=1:population
    R=16;
    while R>15
        velocityx(i) = 0.1*rand();
        velocityy(i) = 0.1*rand();
        
        posx(i) = 30 + 30* rand(); 
        posy(i) = 30 + 30* rand();
        R = sqrt((posx(i)-centro)^2+(posy(i)-centro)^2);
    end
        
    ppbestx(i) = posx(i);
    ppbesty(i) = posy(i);
    
    Pcost = cost(posx(i),posy(i));
    Pgbest = cost(pgbestx,pgbesty);
    
    if Pcost <= Pgbest
            pgbestx = ppbestx(i);
            pgbesty = ppbesty(i);
    end
end

circ = [-15:0.1:15];
circy = sqrt(225-circ.^2);
canvasx =[0:1:1000];
canvasy =[0:1:1000];
objectx = [-50:1:50];
objecty = [-150:3:150];

plot(posx,posy,'.r');
hold on
plot(45+circ, 45+circy, 45+circ, 45-circy);
plot(pgbestx,pgbesty,'.b','MarkerSize',10);
plot(450+objectx, 300*ones(length(objectx)), 450+objectx, 600*ones(length(objectx)));
plot(400*ones(length(objecty)), 450+objecty, 500*ones(length(objecty)), 450+objecty);
plot(canvasx,0);
plot(0,canvasy);
plot(700,700,'.b','MarkerSize',20);

c1 = 1;
c2 = 1;

j=1;

while Pcost > 10;
    for i = 1:population
       boundary=1;
       while boundary == 1
            velocityxaux(i) = velocityx(i) + 10^-4*((c1*rand()*(ppbestx(i) - posx(i))) + (c2*rand()*(pgbestx - posx(i))));
            velocityyaux(i) = velocityy(i) + 10^-4*((c1*rand()*(ppbesty(i) - posy(i))) + (c2*rand()*(pgbesty - posy(i))));
       
            posxaux(i) = posx(i) + velocityxaux(i);
            posyaux(i) = posy(i) + velocityyaux(i);
            
            if 400 <= posxaux(i) && posxaux(i) <= 500 && 300 <= posyaux(i) && posyaux(i) <= 600 
                boundary = 1;
                
                if posxaux(i) <= 450
                    velocityx(i) = -0.5;
                else
                    velocityx(i) = 0.5;
                end
                
                if posyaux(i) <= 450
                    velocityy(i) = -0.5;
                else
                    velocityy(i) = 0.5;
                end
                
            else
                boundary = 0;
                posx(i) = posxaux(i);
                posy(i) = posyaux(i);
                velocityx(i) = velocityxaux(i);
                velocityy(i) = velocityyaux(i);
            end
            
       end
       Pcost = cost(posx(i),posy(i));
       Ppbest = cost(ppbestx(i),ppbesty(i));
       Pgbest = cost(pgbestx,pgbesty);
       
       if Pcost <= Ppbest
           ppbestx(i) = posx(i);
           ppbesty(i) = posy(i);
           
           if Pcost <= Pgbest
               pgbestx = posx(i);
               pgbesty = posy(i);
           end           
       end
    end

hold on
plot(pgbestx,pgbesty,'.g','MarkerSize',10);    
j=j+1;
end
