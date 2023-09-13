function [cluster, clustersizes] = markclusters(Z)

nrows=size(Z,1);
ncols=size(Z,2);

cluster=zeros(nrows,ncols);

clusternum=0;

for i=1:nrows
    for j=1:ncols
        
        if cluster(i,j)==0 && Z(i,j)==1 %this is an unmarked member
            
            clusternum=clusternum+1;
            cluster(i,j)=clusternum;
            
          
            
            for jnext=j+1:ncols
                if Z(i,jnext)==0
                    break;
                elseif cluster(i,jnext)==0
                    cluster(i,jnext)=clusternum;
                    
                end
            end
            
            
            
        end
        
    end
    
    
end

for numtimes=1:max([nrows, ncols])
    changed=0;
    for i=1:nrows
        for j=1:ncols
            
            
            if i+1<=nrows
                if cluster(i+1,j)~=cluster(i,j) && cluster(i+1,j)~=0  && cluster(i,j)~=0
                    changed=1;
                    
                    for alli=1:nrows
                        for allj=1:ncols
                            if cluster(alli,allj)==cluster(i+1,j);
                                cluster(alli,allj)=cluster(i,j);
                            end
                        end
                    end
                end
            end
            
            if i-1>=1
                if cluster(i-1,j)~=cluster(i,j) && cluster(i-1,j)~=0  && cluster(i,j)~=0
                    changed=1;
                    
                    for alli=1:nrows
                        for allj=1:ncols
                            if cluster(alli,allj)==cluster(i-1,j);
                                cluster(alli,allj)=cluster(i,j);
                            end
                        end
                    end
                end
            end
            
            
            if j+1<=ncols
                if cluster(i,j+1)~=cluster(i,j) && cluster(i,j+1)~=0  && cluster(i,j)~=0
                    changed=1;
                    
                    for alli=1:nrows
                        for allj=1:ncols
                            if cluster(alli,allj)==cluster(i,j+1);
                                cluster(alli,allj)=cluster(i,j);
                            end
                        end
                    end
                end
            end
            
            if j-1>=1
                if cluster(i,j-1)~=cluster(i,j) && cluster(i,j-1)~=0  && cluster(i,j)~=0
                    changed=1;
                    
                    for alli=1:nrows
                        for allj=1:ncols
                            if cluster(alli,allj)==cluster(i,j-1);
                                cluster(alli,allj)=cluster(i,j);
                            end
                        end
                    end
                end
            end
            
        end
    end
    
    if changed==0
        break;
    end
end


totalclusters=0;
clustersizes=zeros(1,1);
for clusternumber=1:max(max(cluster))
    
    if sum(sum(cluster==clusternumber))~=0
        totalclusters=totalclusters+1;
        clustersizes(totalclusters,1)= sum(sum(cluster==clusternumber));
        
        if clusternumber ~=totalclusters
            
            for alli=1:nrows
                for allj=1:ncols
                    if cluster(alli,allj)==clusternumber;
                        cluster(alli,allj)=totalclusters;
                    end
                end
            end
        end
        
        
    end
    
end






