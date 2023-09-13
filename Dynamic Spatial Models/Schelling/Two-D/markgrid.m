function [X] = markgrid(Z,v)

nrows=size(Z,1);
ncols=size(Z,2);

for n=1:max([nrows ncols])
    for i=1:nrows
        for j=1:ncols
            
            atleast1=0;
            
            if Z(i,j)==0
                
                
                if i-1>=1
                    if Z(i-1,j)==v
                        atleast1=atleast1+1;
                    elseif Z(i-1,j)~=0
                        continue
                        
                    end
                end
                
                if i+1<=nrows
                    if Z(i+1,j)==v
                        atleast1=atleast1+1;
                    elseif Z(i+1,j)~=0
                        continue
                        
                    end
                end
                
                if j-1>=1
                    if Z(i,j-1)==v
                        atleast1=atleast1+1;
                    elseif Z(i,j-1)~=0
                        continue
                        
                    end
                end
                
                if j+1<=ncols
                    if Z(i,j+1)==v
                        atleast1=atleast1+1;
                    elseif Z(i,j+1)~=0
                        continue
                        
                    end
                end
                
                
                if atleast1>0
                    Z(i,j)=v;
                end
            end
        end
    end
    
end
X=Z==v;




end

