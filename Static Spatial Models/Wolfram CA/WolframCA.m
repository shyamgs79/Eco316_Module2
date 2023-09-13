%Wolfram's 1D CA


clc
close all
clear all


n=100; %the number of cells in a row
gens=100; % the number of generations.

%the rule can be anything between 0 and 255
%rule=12; %example
%rule=0; %tun off no matter what
%rule=255; %turn on no matter what
%rule=204; %stay on if on
%rule=170; %do what's on your right
rule=110; %a complex fascinating pattern
%rule=30;  %a complex fascinating pattern
%rule=90;% a complex pattern a bit like 30 - try with 1 only for center.

%rule=1;

rulestring=dec2bin(rule,8); %convert to rule string

ruleval=zeros(8,1);%initializing array in which to store rules

for i=1:8
    ruleval(9-i)=str2double(rulestring(i));
end


caoutput=zeros(gens,n); %initializing the output array

caoutput(1,:)=(rand(1,n) > .5);  %populating the first row with 1s randomly
%caoutput(1,round(n/2))=1;  %populating the first row with a central 1 only

for g=2:gens
    
    for i=1:n
        
        if i-1<1
            left=caoutput(g-1,n); %loop around if leftmost cell
        else
            left=caoutput(g-1,i-1); %value of cell on left
        end
        
        if i+1>n
            right=caoutput(g-1,1); %loop around if rightmost cell
        else
            right=caoutput(g-1,i+1); %value of cell on right
        end
        
        center=caoutput(g-1,i);
        
        rulenum=1+(4*left+2*center+1*right); % finding the 'number' of the initial state
        
        caoutput(g,i)=ruleval(rulenum); %use rule to find what next state should be
    end
end

spy(caoutput);
        
    

