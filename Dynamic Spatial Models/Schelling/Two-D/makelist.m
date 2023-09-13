function [listmade] = makelist(givenmat)
%Makes a list of all the ones in a given matrix

totones=sum(sum(givenmat));

if totones==0
    
    %if noones in the matrix, return a value of 0
    listmade=0; 
    return;
else
    listmade=zeros(totones,1);
end

m=size(givenmat,1);
n=size(givenmat,2);

ctr=0;

for index=1:n*m
    if givenmat(index)==1
            ctr=ctr+1;
            listmade(ctr,1)= index;
            
            if ctr==totones
                return;
            end
    end
end




% 
% 
% for j=1:n;
%     for i=1:m              
%         
%         if givenmat(i,j)==1
%             ctr=ctr+1;
%             
%             %this creates the index value of that location
%             listmade(ctr,1)= m*(j-1)+i;
%             
%             if ctr>totones
%                 return;
%             end
%         end        
%         
%     end  
   
% end
end

