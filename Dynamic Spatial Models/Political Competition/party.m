clc
clear all
close all

numagents=1000; %number of agents
x=zeros(numagents,1); % x coordinate (preference for x) of agents
y=zeros(numagents,1); %y coordinate (preference for y) of agents

numt=5000; %number of time periods for which to observe dynamics

partytypes=[1,3]; %this vector contains the number and type of each party

%1 - hunter
%2 - aggregator
%3 - predator
%4 - sticker

numparties=size(partytypes,2); %number of parties comes from length of vector above
px=zeros(numparties,1); %x coordinates of parties
py=zeros(numparties,1); %y coordinates of parties
hunterdir=zeros(numparties,1); %in case parties are hunters, they need an initial direction

space=100; %width of preference space.

%Initializing preference space

for i=1:numagents
    x(i)=(space/3)*randn; %preference for x: notice that we are using the random normal distribution here here 
    y(i)=(space/3)*randn; %preference for y: notice that we are using the random normal distribution here here 
end

%we discretize and 'normalize' xs and ys for convenience
xyrange=1+2*max([max(x),abs(min(x)), max(y), abs(min(y))]); %find the max range - height or width, also desire symetry about 0.
g=ceil(xyrange); %calculated width of policy space

% agentgrid=zeros(g);

for i=1:numagents
    x(i)=ceil(x(i)+g/2); %discretizing preference for x
    y(i)=ceil(y(i)+g/2); %discretizing preference for y
   %agentgrid(x(i),y(i))=1;
end

%  figure
%  imagesc(agentgrid);
%  
%  figure
%  spy(agentgrid);

figure %create a new figure
scatter(x,y,20)  % we are using scatter here rather than spy or imagesc
xlim([1 g]); %just to ensure scaling is consistent with calculated width
ylim([1 g]); %just to ensure scaling is consistent with calculated width

%eight directions for hunter defined
xdirs=[0,1,1,1,0,-1,-1,-1];
ydirs=[1,1,0,-1,-1,-1,0,1];

%zvec is used solely to color code scatter plot
zvec=zeros(numparties,1);


%cycling through all parties to initilize party locations
for p=1:numparties
    
    %if hunter also assign an initial direction 
    if partytypes(p)==1
        hunterdir(p)=randi(8);
    end
    
    %assign a random location in policy space for party p    
    px(p)=randi(g);
    py(p)=randi(g);
    
    zvec(p,1)= p; 
    
end

figure
scatter(px,py,130,zvec,'filled')
xlim([1 g]);
ylim([1 g]);

%adding text to plot to make identification of parties easier
for p=1:numparties
    text(px(p), py(p), strcat(' #', num2str(p)));
end
drawnow


%conduct first poll
polls=sumvotes(x,y, numagents, px, py, numparties);

%matrix to store poll history
pollhist=zeros(numt, numparties);
pollhist(1,:)=polls;

%continue through numt time periods
for t=2:numt
    
    %cycle through all parties randomly
    for p = randperm(numparties)
 
        
        %hunter
        if partytypes(p)==1
            
            %if we are in the second period or if there was progress made
            %in last move
            if t==2 || pollhist(t-1,p)>pollhist(t-2,p)
                
                %continue moving in same x direction
                px(p)=px(p)+xdirs(hunterdir(p));
                
                %if the hunter hits the edge of the grid, relocate to
                %initial location
                if px(p)<1 || px(p)>g
                    px(p)=px(p)-xdirs(hunterdir(p));
                end
                
                %same for ys
                py(p)=py(p)+ydirs(hunterdir(p));
                
                if py(p)<1 || py(p)>g
                    py(p)=py(p)-ydirs(hunterdir(p));
                end
                
            %we enter the else if hunter did not gain from last move    
            else
                
                %new direction # is 2, 3,4, 5, or 6 plus old direction#
                hunterdir(p)=hunterdir(p)+4 +randi([-2,2]);
                
                %if new direction# is greater than 8 recalculate direction#
                if hunterdir(p)>8
                    hunterdir(p)=hunterdir(p)-8;
                end
                
                %move in assigned direction
                px(p)=px(p)+xdirs(hunterdir(p));
                
                if px(p)<1 || px(p)>g
                    px(p)=px(p)-xdirs(hunterdir(p));
                end
                
                py(p)=py(p)+ydirs(hunterdir(p));
                
                if py(p)<1 || py(p)>g
                    py(p)=py(p)-ydirs(hunterdir(p));
                end
            end
        
        %aggregator    
        elseif partytypes(p)==2
            
            %find mean of all current voters - move there
            [pxtemp,pytemp]=aggmean(x,y, numagents, px, py, numparties,p);
            
            px(p)=pxtemp;
            py(p)=pytemp;
            
        
        %predator
        elseif partytypes(p)==3
            
            %find which party was at the top
            [~,topparty]=max(pollhist(t-1,:));
            
            %if that party had a higher x coordinate, increase x coordinate
            %by 1
            if px(p)<px(topparty)
                px(p)=px(p)+1;
            
            %else if it had a lower x coordinate decrease x coordinate by 1
            %implicitly, do nothing if x coordinate is the same
            elseif px(p)>px(topparty)
                px(p)=px(p)-1;
            end
            
            %same for y coordinates
            if py(p)<py(topparty)
                py(p)=py(p)+1;
            elseif py(p)>py(topparty)
                py(p)=py(p)-1;
            end
            
        %else sticker: but do nothing for sticker. px(p)=px(p); py(p)=py(p)
            
            
        end
        
       
    end
    
    %recompute polls
    polls=sumvotes(x,y, numagents, px, py, numparties);
    %store poll history
    pollhist(t,:)=polls; 
    
    %draw scatter plot - notice that size of bubbles linearly related to
    %vote share. if party receives all the votes, the size of the bubble is
    %810. If it receives no votes, the size of the bubble is 10.
    scatter(px,py,10+800*(polls/numagents),zvec,'filled')
    xlim([1 g]);
    ylim([1 g]);
    for p=1:numparties
        text(px(p), py(p), strcat(' #', num2str(p)));
    end
    drawnow
    

    
end
                
                
                    




    


