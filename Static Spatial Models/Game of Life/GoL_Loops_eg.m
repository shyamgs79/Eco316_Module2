clear all
close all
clc;

n=40;
m=40;

tic
numsims=100;
numalivedata=zeros(numsims,8);

for sim=1:numsims
    
    % Create a 40X40 grid
    X = zeros(n,m); %Note for a square matrix, X=zeros(n) will do just as well
    
    % Y captures what happens to the grid in the next period;
    Y = zeros(n,m);
    
    
    % Randomly populate the central 100 squares
    % Each cell in the centre has a 25% probability of being alive
    X(16:25,16:25) = (rand(10,10) < .25);
    
    
    
    
    % Instead of (rand(10,10) < .25) you could put in any initial distribution
    % Five examples are provided below
    
    %1. R-Pentonimo%
    %X(19:21, 19:21)=[0 1 1; 1 1 0; 0 1 0];
    
    
    %2. Blinker
    %X(19:21,20)=ones(3,1);
    %
    %3. Toad
    %X(20:21,18:21) = [0 1 1 1; 1 1 1 0];
    
    %4. Glider%
    %X(19:21, 19:21)= [0 1 0; 0 1 1; 1 0 1];
    
    % %5. Pentadecathalon
    %X(16:25, 20) = ones(10,1);
    
    
    Z=X; %Z stores starting value throughout all the loops below.
    %spy(Z);
    % pause
    
    for nn=1:8
        % Simulate for 40 periods.
        
        X=Z;
        
        for t=1:40
            %     spy(X)
            %     title(strcat('This is iteration number: ', num2str(t)));
            %     drawnow
            %pause(0.1)
            
            for i=1:n
                for j=1:m
                    
                    numalive=countliveneighbors2(i,j,X);
                    
                    if (X(i,j)==1 && numalive==2)||(numalive==nn)
                        Y(i,j)=1;
                        
                    else
                        Y(i,j)=0;
                    end
                end
            end
            
            if X==Y
                break
            else
                X=Y;% updating occurs for all cells together
            end
        end
        totalalive=sum(X,'all');
        numalivedata(sim,nn)=totalalive;
        
        
    end
end
toc



