function numalive = countliveneighbors2(i,j,X)

n=size(X,1);
m=size(X,2);

w=1;%Number of layers or width

numalive=0;

for row=i-w:i+w
    
    %checking to see if out of bounds along the rows and adjusting
    %coordinate accordingly
    
    if row>=1 && row<=n
        rowcood=row;
    elseif row<1
        rowcood=n+row;
    else
        rowcood=row-n;
    end
    
    
    
    
    for col=j-w:j+w
        
              
        if col>=1 && col<=m
            colcood=col;
        elseif col<1
            colcood=m+col;
        else
            colcood=col-m;
        end
        
        
        %if cell is itself, don't consider it any further
        % continue takes the program to the next iteration of the loop
        if rowcood==i && colcood==j
            continue;
        end
        
        numalive=numalive+X(rowcood, colcood);
    end
end



