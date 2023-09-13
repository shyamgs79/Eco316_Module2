function [ g ] = Ghetto(Z)

nrows=size(Z,1);
ncols=size(Z,2);

numagents=0;
numnotinghetto=0;


for i=1:nrows
    for j=1:ncols
        
        if Z(i,j)==0
            continue;
        end
        
        numagents=numagents+1;
        
        [numRnbrs, numBnbrs] = countnbrs(i,j,Z);
        
        if Z(i,j)==1 && numBnbrs>0
            numnotinghetto=numnotinghetto+1;
        end
        
        if Z(i,j)==-1 && numRnbrs>0
            numnotinghetto=numnotinghetto+1;
        end
        
        
    end
end

                
g=(numagents-numnotinghetto)/numagents;
                
      
                
                




end

