function numalive = countliveneighbors(i,j,X)

%West Neighbor
west=0;

if i==1
    if X(size(X,1),j)==1
        west=1;
    end
    
else
    if X(i-1,j)==1
        west=1;
    end
end

%east Neighbor
east=0;

if i==size(X,1)
    if X(1,j)==1
        east=1;
    end
    
else
    if X(i+1,j)==1
        east=1;
    end
end

%North Neighbor
north=0;

if j==1
    if X(i,size(X,2))==1
        north=1;
    end
    
else
    if X(i,j-1)==1
        north=1;
    end
end

%South Neighbor
south=0;

if j==size(X,2)
    if X(i,1)==1
        south=1;
    end
    
else
    if X(i,j+1)==1
        south=1;
    end
end

%NW Neighbor
nw=0;

if i==1
    if j==1
        if X(size(X,1),size(X,2))==1
            nw=1;
        end
        
    else
        if X(size(X,1),j-1)==1
            nw=1;
        end
    end
    
else
    if j==1
        if X(i-1,size(X,2))==1
            nw=1;
        end
    else
        if X(i-1,j-1)==1
            nw=1;
        end
    end
end

%NE Neighbor
ne=0;

if i==1
    if j==size(X,2)
        if X(size(X,1),1)==1
            ne=1;
        end
        
    else
        if X(size(X,1),j+1)==1
            ne=1;
        end
    end
    
else
    if j==size(X,2)
        if X(i-1,1)==1
            ne=1;
        end
    else
        if X(i-1,j+1)==1
            ne=1;
        end
    end
end

%SW Neighbor
sw=0;

if i==size(X,1)
    if j==1
        if X(1,size(X,2))==1
            sw=1;
        end
        
    else
        if X(1,j-1)==1
            sw=1;
        end
    end
    
else
    if j==1
        if X(i+1,size(X,2))==1
            sw=1;
        end
    else
        if X(i+1,j-1)==1
        sw=1;
        end
    end
end

%SE Neighbor
se=0;

if i==size(X,1)
    if j==size(X,2)
        if X(1,1)==1
            se=1;
        end
        
    else
        if X(1,j+1)==1
            se=1;
        end
    end
    
else
    if j==size(X,2)
        if X(i+1,1)==1
            se=1;
        end
    else
        if X(i+1,j+1)==1
            se=1;
        end
    end
end

numalive=west+east+north+south+nw+ne+sw+se;


return

