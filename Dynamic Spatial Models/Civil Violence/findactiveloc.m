function [tempr, tempc]=findactiveloc(S_grid, N, r, c, vision)
%Searches randomly through vision to find active agent


%First we will make a coordinates matrix.
%The general pattern is going to be as follows
%If the first element is <= the second element, then the
%coordinates to consider are the 3rd and 4th elements.  If not, the
%coordinates to consider are the 5th and 6th elements.

%We need a general pattern in order to be able to randomize the
%direction of search

%The coordinates matrix will have as many rows as the length of vision*4

coods=zeros(vision*4,6);

%over the length of vision
for v=1:vision
    
    %Making a coordinates matrix.
    %The general pattern is going to be as follows
    %If the first element is <= the second element, then the
    %coordinates to consider are the 3rd and 4th elements.  If not, the
    %coordinates to consider are the 5th and 6th elements.
    
    %We need a general pattern in order to be able to randomize the
    %direction of search
    
    %Looking South
    coods((v-1)*4+1,:)=[r+v   N    r+v  c      r+v-N  c];
    %Looking North
    coods((v-1)*4+2,:)=[v-r  -1    r-v  c      r-v+N  c];
    
    %Looking East
    coods((v-1)*4+3,:)=[c+v  N    r  c+v     r  c+v-N];
    %Looking West
    coods((v-1)*4+4,:)=[v-c  -1   r  c-v     r   c-v+N];
end


%randomizing over all rows of the coordinates matrix
for i=randperm(vision*4)
    
    %First decide which coordinates to consider based on torus
    if coods(i,1)<=coods(i,2)
        currentr=coods(i,3);
        currentc=coods(i,4);
    else
        currentr=coods(i,5);
        currentc=coods(i,6);
    end
    
    %if the location considered has an active agent return the coordinates
    %of that location
    if S_grid(currentr, currentc)==5
        tempr=currentr;
        tempc=currentc;
                
        %As soon as the location has been decided we can break out of the
        %function entirely
        return;
    end
end

%the program reaches this stage only if there are no active locations in
%entire vision
tempr=0;
tempc=0;


end

