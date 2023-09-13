function polls=sumvotes(x,y, numagents, px, py, numparties)
%
%add all the votes for the parties

polls=zeros(1,numparties);

%see who the agent votes for
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
    
    %add one to the chosen party's vote tally 
    polls(partychosen)=polls(partychosen)+1;
      
    
end

