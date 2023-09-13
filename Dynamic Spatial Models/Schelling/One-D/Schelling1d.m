clc;
clear all;
close all;

%Ring Size
N=200;

%Num of types blue (should be less than N)
nB=100;
nR=N-nB;

%percent needed to be happy
Bper=0.5;
Rper=0.5;


%Create random vector - 1s are reds, -0s are blues
temp=[ones(1,nR) zeros(1,nB)];
%the above creates a single vector with one row and nR+nB columns.  The
%first NR columns will be ones.  The remaining columns will be 0s.


Z=temp(randperm(N));
%this sorts the contents of temp in a random order and stores it in Z

imagesc(Z);
pause(2);

X=Z;



%rearrange members on the ring at most 500 times.  Typically the ring is
%fully segregated before 500 iterations.

for i=1:1:500
    
    
    
    [Rpotutil, Bpotutil, Utils] = findutils1d(Z, Rper, Bper);
    %This function creates three vectors. Rpotutil contains the potential
    %utility that red could earn in each location. Bpotutil contains the
    %potential utility that blue could earn in each location. Utils contains
    %the actual utility of the member in each location.
    
    
    
    
    %if everyone is happy, draw the image and break out of the program.
    if min(Utils)==100
        
        imagesc(Z);
        title(num2str(i));
        drawnow;
        
        break
        
        
    end
    
    
    %find the least happy person and their current index (location); Note
    %that if there are multiple people with the same utility, then Matlab
    %will return the index of the first person it comes across with this
    %low utility
    [minval, personchosen]=min(Utils);
    
    
    if Z(personchosen)==1
        [maxval, indexchosen]=max(Rpotutil);
        %if the person is red, find the location (indexchosen) with the
        %highest potential utility for red
        
    else
        [maxval, indexchosen]=max(Bpotutil);
        %if the person is blue, find the location (indexchosen) with the
        %highest potential utility for blue
        
        
    end
    
    
    %the following if then statements appear complex.  All they are doing
    %though is inserting the person chosen at the location indexchosen and
    %rearranging all the remaining cells accordingly. The new arrangement
    %is stored in NZ
    
    if personchosen<indexchosen %implies indexchosen>1
        if personchosen>1
            NZ=[Z(1:personchosen-1) Z(personchosen+1:indexchosen-1) Z(personchosen) Z(indexchosen:N)];
        else
            NZ=[Z(2:indexchosen-1) Z(personchosen) Z(indexchosen:N)];
        end
        
    elseif personchosen>indexchosen %implies personchosen>1, indexchosen<N
        
        if personchosen<N && indexchosen>1
            NZ=[Z(1:indexchosen-1) Z(personchosen) Z(indexchosen:personchosen-1) Z(personchosen+1:N)];
            
        elseif indexchosen==1 %implicitly, personchosen cannot be N
            NZ=[Z(personchosen) Z(1:personchosen-1) Z(personchosen+1:N)];
            
        elseif personchosen==N %implicitly, indexchosen cannot be 1
            NZ=[Z(1:indexchosen-1) Z(N) Z(indexchosen:N-1)];
            
        end
        
    end
    
    
    %If NZ is identical to Z then break out of the loop
    if sum(abs((NZ-Z)))==0
        imagesc(NZ);
        title(num2str(i));
        drawnow
        break;
    end
    
    %pass on the new value of NZ to Z
    Z=NZ;
    X=[X;Z];
    %draw a picture of NZ every second iteration
    if mod(i,2)==0
        imagesc(NZ);
        title(num2str(i));
        drawnow
        
    end
    
end

figure
imagesc(X);