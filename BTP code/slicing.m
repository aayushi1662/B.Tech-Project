function [list_of_triangles,n] = slicing( vertex ,slice_height,zc,normal)
    list_of_triangles={}; n={}; j=1;
     for i=1:size(vertex)
       if mod(i,3)==0
           a=[];
           z1=vertex(i-2,:);
            z2= vertex(i-1,:);
            z3=vertex(i,:);
           if(z1(3)<zc && z2(3)>zc)|| (z1(3)>zc && z2(3)<zc)
               a=[vertex(i-2,:);vertex(i-1,:);vertex(i,:)];
               list_of_triangles=[list_of_triangles;a];
                n=[n;normal(j,:)];
           elseif (z2(3)<zc && z3(3)>zc)|| (z2(3)>zc && z3(3)<zc)
                a=[vertex(i-2,:);vertex(i-1,:);vertex(i,:)];
               list_of_triangles=[list_of_triangles;a];
                n=[n;normal(j,:)];
           elseif (z1(3)<zc && z3(3)>zc)|| (z1(3)>zc && z3(3)<zc)
               a=[vertex(i-2,:);vertex(i-1,:);vertex(i,:)];
               list_of_triangles=[list_of_triangles;a];
                n=[n;normal(j,:)];
           elseif ((z1(3)==zc && z2(3)==zc) || (z2(3)==zc && z3(3)==zc)|| (z3(3)==zc && z1(3)==zc))
               a=[vertex(i-2,:);vertex(i-1,:);vertex(i,:)];
               list_of_triangles=[list_of_triangles;a];
                n=[n;normal(j,:)];
           end
           j=j+1;
       end
     end
   list_of_triangles=cell2mat(list_of_triangles);  
end

