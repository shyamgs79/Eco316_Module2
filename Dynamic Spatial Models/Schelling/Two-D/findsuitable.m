function [Rsuit, Bsuit] = findsuitable(Z, Rper, Bper)

    %This function returns two matrices.  One contains all locations
    %suitable for red and the other contains all locations suitable for
    %blue

nrows=size(Z,1);
ncols=size(Z,2);

Rsuit=zeros(nrows, ncols);
Bsuit=zeros(nrows, ncols);

for i=1:nrows
    for j=1:ncols
        
        [numRnbrs, numBnbrs] = countnbrs(i,j,Z);
        
        numnbrs=numRnbrs+numBnbrs; %total number of human neighbors
        
        if numnbrs==0 % if this a cell surrounded by empty space
            Rsuit(i,j)=1;
            Bsuit(i,j)=1;
            continue
        end
        
        if numRnbrs/(numnbrs) >= Rper
            Rsuit(i,j)=1;
        end
        
        if numBnbrs/(numnbrs) >= Bper
            Bsuit(i,j)=1;
        end
    end
end

        
        









end