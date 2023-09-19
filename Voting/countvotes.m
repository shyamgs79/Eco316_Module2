function [numones, numzeros] = countvotes(i,j,X)

nrows=size(X,1); %number of rows
ncols=size(X,2); %number of columns

w=1;%Number of layers or width

numzeros=0; %initial number of zeros
numones=0; %initial number of ones

for row=i-w:i+w
    
    %checking to see if out of bounds along the rows and adjusting
    %coordinate accordingly
    
    if row>=1 && row<=nrows
        rowcood=row;
    else
        continue
    end
    
    
    
    
    for col=j-w:j+w
        
              
        if col>=1 && col<=ncols
            colcood=col;
        else 
            continue;
        end
        
        
        %if cell is itself, don't consider it any further
        % continue takes the program to the next iteration of the loop
        if rowcood==i && colcood==j
            continue;
        end
        
        if X(rowcood,colcood)==1
            numones=numones+1;
        else
            numzeros=numzeros+1;
        end
    end
end
end
