clear all;
clc;
close all;

%Size of Map
nrows=50;
ncols=50;


%Initial Distribution of Votes
probone=0.5;

%Initialize Map
City=(rand(nrows,ncols)>probone);
NCity=City;

figure
imagesc(City);
title('Initial State');
drawnow
pause;

figure
%Number of Time Periods
time=1000;


changeiftied=0;
changeifcloseloss=1;


for t=1:time
    %pause(0.5) %pause for effect!
    
    for i=1:nrows
        for j=1:ncols
            
            [numones, numzeros] = countvotes(i,j,City); %count neighbor votes
            
            
            %the following only kicks in if there is a close-loss and we
            %need to worry about it.
            if abs(numones-numzeros)<=2 && (changeifcloseloss==1)
                if numones>numzeros
                    NCity(i,j)=0;
                    continue;
                elseif numzeros>numones
                    NCity(i,j)=1;
                    continue;
                end
            end
            
            
            %the following only kicks in if there is a tie and we
            %need to worry about it.
            if (numones==numzeros) && (changeiftied==1)
                NCity(i,j)=1-City(i,j);
                continue;
            end
            
            
            %the following kicks in only if the above conditions have not
            %been met
            if numones>numzeros
                NCity(i,j)=1;
            elseif numzeros>numones
                NCity(i,j)=0;
            else
                NCity(i,j)=City(i,j);
            end
            
            
        end
    end
    
    if City==NCity
        break
    end
    
    
    City=NCity;
    imagesc(City);
    title(num2str(t));
    drawnow;
    
end

 %imagesc(City)