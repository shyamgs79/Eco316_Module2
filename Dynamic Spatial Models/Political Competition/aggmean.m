function [pxtemp,pytemp]=aggmean(x,y, numagents, px, py, numparties,p)

%find mean position for aggregator

%current position of aggregatot
pxtemp=px(p);
pytemp=py(p);

%sum of x cordinates
sumx=0;

%sum of y coordinates
sumy=0;

%number of supporters
numsupporters=0;

%loop through all agents
for i=1:numagents
    
    %assume the agent's minimum distance from any party is infinity
    mindistsq=inf;
    %assume that chosen party is 1
    partychosen=1;
    
    %loop through all parties randomly
    for j=randperm(numparties)
        
        %find distance
        distsq=(x(i)-px(j))^2 + (y(i)-py(j))^2;
        
        %is this distance less than current minimum didstance?
        if distsq<mindistsq
            %set current minimum to the distance from this party
            mindistsq=distsq;
            %this is the currently chosen party
            partychosen=j;
        end
    end
    
    %is this the party of the aggregator under consideration?
    if partychosen==p
        
        %add this x coordinate to the sum of x coordinates
        sumx=sumx+x(i);
        
        %add this y coordinate to the sum of y coordinates
        sumy=sumy+y(i);
        
        %add 1 to the number of supporters
        numsupporters=numsupporters+1;
    end
      
    
end


%if party has at least one supporter, then go to mean of supporter
%coordinates
if numsupporters>0
    pxtemp=round(sumx/numsupporters);
    pytemp=round(sumy/numsupporters);
end


end

