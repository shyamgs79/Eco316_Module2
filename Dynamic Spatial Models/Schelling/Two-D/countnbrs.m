function [numRnbrs, numBnbrs] = countnbrs(i,j,Z)

nrows=size(Z,1); %number of rows
ncols=size(Z,2); %number of columns

w=1;%Number of layers or width

numRnbrs=0; %initial number of Red neighbors
numBnbrs=0; %initial number of Blue neighbors

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
        
        if Z(rowcood,colcood)==1
            numRnbrs=numRnbrs+1;
        elseif Z(rowcood,colcood)== -1
            numBnbrs=numBnbrs+1;
        end
    end
end
end
