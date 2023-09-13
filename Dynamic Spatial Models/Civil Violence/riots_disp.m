%Main program

clc
clear all
close all




%Grid Size
N=40;

%Agent denisty
adensity=0.7;
cdensity=0.04;

numagents=round(adensity*N*N);
numcops=round(cdensity*N*N);

%Legitmacy
L=0.82;

%Threshold
Threshold=0.1;

%k
konst=2.3;

%Max Jail term
J_max=30;

%Making P_grid - each cell in this grid contains the agent# of the person
%living there or 0 if noone is living there.  Civilian agents have 
%agentnumbers ranging from 1 to numagent.  Cops have agentnumbers ranging
%from numagent+1 to numcops
P_grid=[1:numagents+numcops zeros(1, N*N-(numagents+numcops))];
P_grid=P_grid(randperm(N*N));
P_grid=reshape(P_grid, N, N);

%Initializing Agent and Cop Vectors
%Only civilians have hardship, riskaversion, and jail time so those vectors
%are only as long as the number of civilian agents
%Both civilians and cops have vision, state, and Row and Column Coordinates
agentvision=7;
copvision=7;

%Hardship of each agent
H_agent=zeros(numagents,1);

%Riskaversion of each agent
Rk_agent=zeros(numagents,1);

%Remaining jail term for each agent (0=not in jail)
J_agent=zeros(numagents,1);

%vision of each agent
V_agent=zeros(numagents+numcops,1);

%state of each agent 0 = in Jail, 1 = Quiet, 5 = Active, 10 = Cop
S_agent=zeros(numagents+numcops,1);

%Row coordinate of each agent
R_agent=zeros(numagents+numcops,1);
%Column coordinate of each agent
C_agent=zeros(numagents+numcops,1);


%In the same loop will create grievance and state grids (G_grid and S_grid)
G_grid=zeros(N,N); %could be 0 for cops or empty spots Grievance for rest
S_grid=zeros(N,N); %could be 0, 1, 5 and 10

for i=1:N
    for j=1:N
        
        %first determining the agent number of that location
         agentnumber=P_grid(i,j);
            
        %If agent on that grid location is a civilian agent
        if agentnumber>0 && agentnumber<=numagents
            
            
            H_agent(agentnumber)=rand;
            G_grid(i,j)=H_agent(agentnumber)*(1-L);
            
            Rk_agent(agentnumber)=rand;
            
            J_agent(agentnumber)=0;
            
            V_agent(agentnumber)=agentvision;
            
            S_agent(agentnumber)=1;
            S_grid(i,j)=S_agent(agentnumber);
            
            R_agent(agentnumber)=i;
            C_agent(agentnumber)=j;
        
        %else if agent on grid location is a cop
        elseif agentnumber>numagents
           
            V_agent(agentnumber)=copvision;
            
            S_agent(agentnumber)=10;
            S_grid(i,j)=S_agent(agentnumber);
            
            R_agent(agentnumber)=i;
            C_agent(agentnumber)=j;
        end
    end
end
figure(1)
subplot(1,2,1), imagesc(G_grid);
colormap jet
axis square
subplot(1,2,2), imagesc(S_grid);
colormap jet
axis square;


numruns=200;

%initializing number of active, jailed, amd quiet agents
countactive=zeros(numruns,1);
countjailed=zeros(numruns,1);
countquiet=zeros(numruns,1);


for t=1:numruns
    
    %going through agent list in random order
    
    for k=randperm(numagents+numcops)
        
        %If agent is a jailed civilian, he stays there and loses a year of
        %jail time. If his jail time is exhausted, he is released as a
        %quiet agent in the same location.  Also updating the Stategrid for
        %that location upon release
        if k<=numagents && S_agent(k)==0
            J_agent(k)=J_agent(k)-1;
            if J_agent(k)==0
                S_agent(k)=1;
                S_grid(R_agent(k), C_agent(k))=1;
            end
            
            %Jailed agents are not moved. If jailed agents can move, the
            %continue statement below needs to be removed
            continue
        end
        
        %The function below moves the current agent to a new vacant
        %location.  The function updates the P_grid. S_grid, G_grid and 
        %agent propoerties are upgraded in the main program, i.e., here
        [P_grid tempr tempc]=moveagent(P_grid, N, R_agent(k), C_agent(k), V_agent(k));
        %tempr and tempc are the location to which the agent has moved
        S_grid(tempr, tempc)=S_agent(k);
        S_grid(R_agent(k), C_agent(k))=0;
        %If applicable, also updating grievance grid
        if k<=numagents
            G_grid(tempr, tempc)= H_agent(k)*(1-L);
            G_grid(R_agent(k), C_agent(k))=0;
        end
        %Finally updating row and column coordinates for that agent
        R_agent(k)=tempr;
        C_agent(k)=tempc;
        
        
        
        
        %if agent is a cop
        if k>numagents
            
            [loccol locrow]=findactiveloc(S_grid, N, R_agent(k), C_agent(k), V_agent(k));
            
            if loccol==0
                continue
            end
            
            S_grid(loccol, locrow)=0;
            arrestedagentnum=P_grid(loccol, locrow);
            S_agent(arrestedagentnum)=0;
            J_agent(arrestedagentnum)=round(J_max*rand);
        
        %if agent is a civilian 
        else
            
            %find ratio of cops to active agents within visible area
            caratio=findcaratio(S_grid, N, R_agent(k), C_agent(k), V_agent(k));
            caratio=floor(caratio);
            %Compute net risk
            Netrisk=Rk_agent(k)*(1-exp(0.0-konst*caratio));
            
            %Decide whether to be active
            if (H_agent(k)*(1-L))-Netrisk > Threshold
                S_agent(k)=5;
                S_grid(R_agent(k), C_agent(k))=5;
            else
                S_agent(k)=1;
                S_grid(R_agent(k), C_agent(k))=1;
            end
        end
    end
    
    countactive(t)=sum(S_agent==5);
    countjailed(t)=sum(S_agent==0);
    countquiet(t)=sum(S_agent==1);
    
    
    figure(2)
    colormap jet
    subplot(1,3,1), imagesc(G_grid);
    axis square
    subplot(1,3,2), imagesc(S_grid);
    axis square
    subplot(1,3,3), plot(1:t,countactive(1:t),'r',1:t,countjailed(1:t),'b', 1:t,countquiet(1:t),'c');
    axis square
    
    
    drawnow
    
    
end
