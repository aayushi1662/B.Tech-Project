function [ a ] = reorder( a,n)
j=1;

for i=1:size(a)
    if mod(i,3)==0
        nn=n(j,:);
        j=j+1;
         z1=a(i-2,:);
            z2= a(i-1,:);
            z3=a(i,:);
            v1=z2-z1;
            v2=z3-z2;
            c=cross(v1,v2);
            d=dot(c,nn);
            if(d<0)
                a(i-2,:)=z1;
                a(i-1,:)= z3;
                a(i,:)= z2;
            else
                 a(i-2,:)=z1;
                a(i-1,:)= z2;
                a(i,:)= z3;
            end
    end
end

end

