function [ p ] = Percentunlike(Z)

nrows=size(Z,1);
ncols=size(Z,2);

numagents=0;
totpercentunlike=0;


for i=1:nrows
    for j=1:ncols
        
        if Z(i,j)==0
            continue;
        end
        
        numagents=numagents+1;
        
        [numRnbrs numBnbrs] = countnbrs(i,j,Z);
        
        if Z(i,j)==1 && (numBnbrs+numRnbrs)>0
            totpercentunlike=totpercentunlike+(numBnbrs/(numBnbrs+numRnbrs));
        end
        
        if Z(i,j)==-1 && (numBnbrs+numRnbrs)>0
            totpercentunlike=totpercentunlike+(numRnbrs/(numBnbrs+numRnbrs));
        end
        
        
    end
end

                
p=totpercentunlike/numagents;
                
      
                
                




end
