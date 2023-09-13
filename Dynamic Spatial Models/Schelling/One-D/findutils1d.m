function [Rpotutil, Bpotutil, Utils] = findutils1d(Z, Rper, Bper)
%This function creates three vectors. Rpotutil contains the potential
    %utility that red could earn in each location. Bpotutil contains the
    %potential utility that red could earn in each location. Utils contains
    %the actual utility of the member in each location.
%


N=size(Z,2);

%initialize all the vectors that need to be output
Rpotutil=zeros(1,N);
Bpotutil=zeros(1,N);
Utils=zeros(1,N);

%this is the width of neighbors on each side
w=4;


%Go through the entire vector, one cell at a time
for i=1:N
    
    %initialize count of red and blue neighbors at 0
    reds=0;
    blues=0;
    
    %look w cells to the left and w cells to the right
    for j=i-w:i+w
        
        %if cell is yourself, go on to next cell
        if j==i
            continue
        end
        
        %if you have hit either boundary, cell under consideration loops
        %back around ring. If not, cell under consideration is the one
        %given by j
        if j<1
            nbr=N+j;
        elseif j>N
            nbr=j-N;
        else
            nbr=j;
        end
        
        %add 1 to reds if the neighbor is red, add 1 to blue otherwise
        if Z(nbr)==1
            reds=reds+1;
        else
            blues=blues+1;
        end
    end
    
    %Compute the potential utility for Reds and Blues at location i
    Rpotutil(i)=(reds/(reds+blues));
    Bpotutil(i)=(blues/(reds+blues));
    
    %if potential utility is greater than max desired, utility is 100
    if Rpotutil(i)>Rper
        Rpotutil(i)=100;
               
    end
    
    if Bpotutil(i)>Bper
        Bpotutil(i)=100;
               
    end
    
    
    %Find actual utility at location i. Util = Red potential if red
    %occupies i else util = blue potential.
    if Z(i) ==1
        Utils(i)=Rpotutil(i);
    else
        Utils(i)=Bpotutil(i);
    end
    
    
    %The following guarantees that we will begin our search for the person
    %with the highest utility with person as far right as possible. This is
    %achieved by adding a small inconsequential number to the utility that
    %diminshes as we move rightwards.  The reason for doing this is that we
    %don't want the program stuck in a local equilibrium.  In a sense we
    %want to pick the unhappiest person going from right to left and the
    %best location for that person going from left to right (the default in
    %Matlab when using min or max commands).
%     if Utils(i) ~= 100
%         Utils(i)=Utils(i)+0.0000025*(N-i);
%     end
    
end



end

