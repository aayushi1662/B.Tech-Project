function [ loops ] = contour_construction( a,zc )
loops={};
c=0;k=0;t=1;arr={};m=size(a);q=0;
while(1)     
for i=1:m
    if( t==1)
    if(a(i,1).x~=-1 && a(i,1).y~=-1 && a(i,2).x~=-1 && a(i,2).y~=-1)
       arr={a(i,1),a(i,2)};
       arr=cell2mat(arr);
        head=arr(1,1);
        a(i,1).x=-1;
        a(i,1).y=-1;
        a(i,2).x=-1;
       a(i,2).y=-1;
        j=1;
       c=c+1;
       t=-1;
    end 
    elseif(isequal(arr(j,2),a(i,1)))    % checking second element is equal to first element of row or not
         arr=[arr;a(i,1),a(i,2)];
         j=j+1;
        tail=arr(end);
         a(i,1).x=-1;
        a(i,1).y=-1;
        a(i,2).x=-1;
       a(i,2).y=-1;
        c=c+1;
        if(isequal(head,tail))
            loops=[loops;arr];          % contain all contours
            t=1;   
        end
    end
    if(c==m(1,1))
        k=1;
        break;
    end
end
if(q==1)
    break;
end
if(k==1)
        break;
    end
end
end