function [P_grid, tempr, tempc]=temppracticemoore(P_grid, N, r, c, vision)

ctr=0;

for i=r-vision:r+vision;
    for j=c-vision:c+vision;
        
        currentrow=i;
        currentcol=j;
        
        if i<1
            currentrow=N+i;
        end
        if i>N
            currentrow=i-N;
        end
        
        if j<1
            currentcol=N+j;
        end
        if j>N
            currentcol=j-N;
        end
        ctr=ctr+1;
        validcol(ctr)=currentcol;
        validrow(ctr)=currentrow;
        
    end
end

for index=randperm(ctr)
    if P_grid(validrow(index),validcol(index))==0
        tempr=validrow(index);
        tempc=validcol(index);
        
        P_grid(tempr,tempc)=P_grid(r,c);
        P_grid(r,c)=0;
        
        %As soon as the location has been decided we can break out of the
        %function entirely
        return;
    end
end

tempr=r;
tempc=c;