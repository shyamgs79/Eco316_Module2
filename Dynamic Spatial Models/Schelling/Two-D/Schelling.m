clc;
clear all;
close all;


%Grid Size
N=60;

%Num of types blue and red (should add up to less than N*N)
nB=1100;
nR=1100;

%percent needed to be happy
Bper=0.5;
Rper=0.5;

%Create random grid: 1s are reds, -1s are blues
temp=[ones(1,nR), -1*ones(1,nB), zeros(1,(N*N-nB-nR))];

temp=temp(randperm(N*N));
Z=reshape(temp,N,N);

%displaying and storing inital value of Z
InZ=Z;
save('savedinitialZ','InZ');
figure
imagesc(InZ);
colormap jet;
title('Inital Z')
figure

%%%%%%%%%%%%%%%%%%%%%%%%
% Computing all segregation measures for inital Z.
%%%%%%%%%%%%%%%%%%%%%%%%%
[InRedclusters, Inredclustersizes]=markclusters(markgrid(InZ,1));
%this function returns a matrix with numbered red clusters and a vector
%with the list of cluster sizes for the red clusters

[InBlueclusters, Inblueclustersizes]=markclusters(markgrid(InZ,-1));
%this function does the same for blue clusters


Intotalclusters=size(Inredclustersizes,1)+size(Inblueclustersizes,1);
%This adds the total number of clusters: red + blue

Inaverageclustersize=(sum(Inredclustersizes)+sum(Inblueclustersizes))/Intotalclusters;
%This computes the average cluster size


Ing= Ghetto(InZ);
%this function returns the percentage of people living in like ghettos

Inp = Percentunlike(InZ);
%this function returns the average percentage of unlike people in
%neighborhood

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%perform at most 2000 iterations.  The program typically ends before.

for i=1:1:2000
    
    
    B=(Z==-1); %create a matrix of ones for all Blue locations
    
    R=(Z==1); %create a matrix of ones for all Red locations
    
    E=(Z==0); %create a matrix of ones for all vacant locations
    
    [Rsuit, Bsuit] = findsuitable(Z, Rper, Bper);
    %This function returns two matrices.  One contains all locations
    %suitable for red and the other contains all locations suitable for
    %blue
    
    %The following creates a matrix of ones for all unhappy blues.    
    UB=B&(~Bsuit); %is a location blue and unsuitable for blue?
    
    %The following creates a matrix of ones for all unhappy reds.    
    UR=R&(~Rsuit); %is a location red and unsuitable for red?
    
    %the following creates a matrix of ones for all locations eligible for
    %blue
    EB=E&Bsuit;
    
    %the following creates a matrix of ones for all locations eligible for
    %red
    ER=E&Rsuit;
    
    %the following creates a matrix of all unhappy reds and blues
    U=UB|UR;
    
    
    
    %if noone is unhappy, draw the image of the neighborhood and break out
    %of the loop
    if sum(sum(U))==0
        
        imagesc(Z);
        colormap jet;
        title(num2str(i));
        drawnow;
        
        break
        
    end
    
    %make a list of all the unhappy cells
    Ulist=makelist(U);
    
    %make a list of cells eligible for blue
    EBlist=makelist(EB);
    
    %make a list of cells eligible for red
    ERlist=makelist(ER);
    
    %choose a person at random from the list of unhappy people
    personchosen=randi(size(Ulist,1));
    
    %if the person is blue and there are eligible blue spots, move the
    %agent
    if Z(Ulist(personchosen))== -1 && EBlist(1)~=0
        spotchosen=randi(size(EBlist,1));
        Z(Ulist(personchosen))=0;
        Z(EBlist(spotchosen))=-1;
        
    %if the person is red and there are eligible red spots, move the
    %agent        
    elseif Z(Ulist(personchosen))== 1 && ERlist(1)~=0
        spotchosen=randi(size(ERlist,1));
        Z(Ulist(personchosen))=0;
        Z(ERlist(spotchosen))=1;
        
    end
    
    
    
    %display an image every 10th iteration
    if mod(i,10)==0
        imagesc(Z);
        colormap jet;
        title(num2str(i));
        drawnow;
    end
    
    
    
end

%%%%% the following let's you see which cells are blue, red, empty, etc.

% figure; spy(B); title('B');
% 
% figure; spy(R); title('R');
% 
% figure; spy(E); title('E');
% 
% figure; spy(Bsuit); title('Bsuit');
% 
% figure; spy(Rsuit); title('Rsuit');
% 
% figure; spy(UB); title('UB');
% 
% figure; spy(UR); title('UR');
% 
% figure; spy(U); title('U');
% 
% figure; spy(EB); title('EB');
% 
% figure; spy(ER); title('ER');


% Computing all segregation measures for final Z.
[Redclusters, redclustersizes]=markclusters(markgrid(Z,1));
[Blueclusters, blueclustersizes]=markclusters(markgrid(Z,-1));

totalclusters=size(redclustersizes,1)+size(blueclustersizes,1);
averageclustersize=(sum(redclustersizes)+sum(blueclustersizes))/totalclusters;

%drawing an image of all blue clusters
figure;
imagesc(Blueclusters);
colormap winter
title('Final Blueclusters');

%drawing an image of all red clusters
figure;
imagesc(Redclusters);
colormap autumn
title('Final Redclusters');

g= Ghetto(Z);
p = Percentunlike(Z);
















