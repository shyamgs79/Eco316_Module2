%Based on example provided by Matlab.
clear all;
close all;
clc;

% Create a 40X40 grid 
X = zeros(40,40);

% Randomly populate the central 100 squares
% Each cell in the centre has a 25% probability of being alive
%X(16:25,16:25) = (rand(10,10) > .75);

% Instead of (rand(10,10)>.75) you could put in any initial distribution
% Five examples are provided below

%1. R-Pentonimo
X(19:21, 19:21)=[0 1 1; 1 1 0; 0 1 0];

%2. Blinker
%X(19:21,20)=ones(3,1);

%3. Toad
%X(20:21,18:21) = [0 1 1 1; 1 1 1 0];

%4. Glider
%X(19:21, 19:21)= [0 1 0; 0 1 1; 1 0 1];

%5. Pentadecathalon
%X(16:25, 20) = ones(10,1);

n = size(X,1);

%Quick way of getting neighbors. p says all rows/columns look "backward"
%one row/column except the first row/column which refers to itself. Q
%refers likewise in a "forward" manner.
%Note that border cells refer to the opposite border


p = [n 1:n-1];
q = [2:n 1];

% Simulate 100 times.
   
for i = 1:500
   
    spy(X)
    title(num2str(i))
    drawnow
    
    %pause 0.02 seconds
    %pause(0.2);
    %pause
    
    % Adding the values of the eight Moore neighbors for each cell
    % Since alive=1 and dead =0, this sum = number of neighbors alive
    
    Y = X(:,p) + X(:,q) + X(p,:) + X(q,:) + X(p,p) + X(q,q) + X(p,q) + X(q,p);
    %(looking left, right, up, down, up-left, down-right,up-right,downleft)
    
    
    % A live cell with two live neighbors, or any cell with
    % three live neigbhors, is alive at the next step and the rest are
    % dead;
    
    X = (X & (Y == 2))   |      (Y == 3);
    
    %the first condition {(X & (Y == 2))} returns alive (1) if a cell is alive and has two living neighbors 
    %the second condition {Y == 3))} returns alive (1) if a cell has three living neighbors
    %together, these conditions returm alive if either (or both) conditions are true
    
end

