function [points,loop1,nn] = intersection(a,zc,n)
points={};loop1={};nn={};k=1;
for i=1:size(a)
     if mod(i,3)==0
         ar=[];
         c=0;
           z1=a(i-2,:);
            z2= a(i-1,:);
            z3=a(i,:);
            if(zc==z1(3) && zc==z2(3) && zc==z3(3))  % CASE 1- triangle lie in the plane
                for j=i-2:1:i-1
                   r1=a(j,:);
                  r2= a(j+1,:); 
                s1.x=r1(1);
                s1.y=r1(2);
                s2.x=r2(1);
                s2.y=r2(2);
                loop1=[loop1;s1,s2];
                end
               s1.x=z3(1);
               s1.y=z3(2);
               s2.x=z1(1);
               s2.y=z1(2);
               loop1=[loop1;s1,s2];
               k=k+1;
               continue;
                elseif(zc==z1(3)&& zc==z2(3))       % CASE 2- any 2 vertex of triangle intersect with the plane
                    s1.x=z1(1);
                    s1.y=z1(2);
                    s2.x=z2(1);
                    s2.y=z2(2); 
                points=[points;s1,s2];
                 nn=[nn;n(k,:)];
                     k=k+1;
                continue;
                 elseif(zc==z2(3)&& zc==z3(3))
                     s1.x=z2(1);
                    s1.y=z2(2);
                    s2.x=z3(1);
                    s2.y=z3(2);
                    points=[points;s1,s2];
                   nn=[nn;n(k,:)];
                       k=k+1;
                    continue;
                 elseif(zc==z3(3)&& zc==z1(3))
                     s1.x=z3(1);
                    s1.y=z3(2);
                    s2.x=z1(1);
                    s2.y=z1(2);
                    points=[points;s1,s2];
                    nn=[nn;n(k,:)];
                        k=k+1;
                    continue;
                end
               if(zc==z1(3))   % CASE 3- one vertex lie on plane and other vertex intersect with plane
                c=c+1;
                s1.x=z1(1);
                s1.y=z1(2);
                u= (zc-z2(3))/(z3(3)-z2(3));    % u=(zc-z0)/(z1-z0)
               
                if(u>0 && u<1)
                s2.x=(z2(1)+u*(z3(1)-z2(1)));        % x=x0+u(x1-x0)
                s2.y=(z2(2)+u*(z3(2)-z2(2)));        % y=y0+u(y1-y0)
                c=c+1;
                end
                if(c==2)
                    points=[points;s1,s2];
                    nn=[nn;n(k,:)];
                        k=k+1;
                    continue;
                end 
                elseif(zc==z2(3))
                     c=c+1;
                     s1.x=z2(1);
                     s1.y=z2(2);
                u= ((zc-z3(3))/(z1(3)-z3(3)));   
                if(u>0 && u<1)
                s2.x=(z3(1)+u*(z1(1)-z3(1)));
                s2.y=(z3(2)+u*(z1(2)-z3(2)));
                c=c+1;
                end
                if(c==2)
                    points=[points;s1,s2];
                    nn=[nn;n(k,:)];
                        k=k+1;
                    continue;
                end 
              elseif(zc==z3(3))
                        c=c+1;
                        s1.x=z3(1);
                        s1.y=z3(2);
                        u= (zc-z1(3))/(z2(3)-z1(3)); 
                       
                if(u>0 && u<1)
                s2.x=(z1(1)+u*(z2(1)-z1(1)));
                s2.y=(z1(2)+u*(z2(2)-z1(2)));
                c=c+1; 
                end
                if(c==2)
                    points=[points;s2,s1];
                    nn=[nn;n(k,:)];
                        k=k+1;
                    continue;
                end
               end
                                     % CASE 4- intersection of triangles edges with plane
                   if(((z1(3)<zc && z2(3)>zc)|| (z1(3)>zc && z2(3)<zc)) && ((z2(3)<zc && z3(3)>zc)|| (z2(3)>zc && z3(3)<zc)) )
                       u1= (zc-z1(3))/(z2(3)-z1(3));
                       u2= (zc-z2(3))/(z3(3)-z2(3));
                      
                       s1.x=(z1(1)+u1*(z2(1)-z1(1)));
                       s1.y=(z1(2)+u1*(z2(2)-z1(2)));
                       s2.x=(z2(1)+u2*(z3(1)-z2(1)));
                       s2.y=(z2(2)+u2*(z3(2)-z2(2)));
                       points=[points;s1,s2];
                       nn=[nn;n(k,:)]; 
                   elseif(((z1(3)<zc && z2(3)>zc)|| (z1(3)>zc && z2(3)<zc))&& ((z1(3)<zc && z3(3)>zc)|| (z1(3)>zc && z3(3)<zc)))
                       u1= (zc-z1(3))/(z2(3)-z1(3));   
                       u2= (zc-z3(3))/(z1(3)-z3(3));
                       
                       s1.x=(z1(1)+u1*(z2(1)-z1(1)));
                       s1.y=(z1(2)+u1*(z2(2)-z1(2)));
                       s2.x=(z3(1)+u2*(z1(1)-z3(1)));
                       s2.y=(z3(2)+u2*(z1(2)-z3(2)));
                       points=[points;s1,s2];
                       nn=[nn;n(k,:)];
                   elseif(((z3(3)<zc && z2(3)>zc)|| (z3(3)>zc && z2(3)<zc)) && ((z1(3)<zc && z3(3)>zc)|| (z1(3)>zc && z3(3)<zc)))
                       u1= (zc-z2(3))/(z3(3)-z2(3));
                       u2= (zc-z3(3))/(z1(3)-z3(3));
                      
                       s1.x=(z2(1)+u1*(z3(1)-z2(1)));
                       s1.y=(z2(2)+u1*(z3(2)-z2(2)));
                       s2.x=(z3(1)+u2*(z1(1)-z3(1)));
                       s2.y=(z3(2)+u2*(z1(2)-z3(2)));
                       points=[points;s1,s2];
                       nn=[nn;n(k,:)]; 
                   end 
                   k=k+1;      
     end                
end
       points=cell2mat(points);
        nn=cell2mat(nn); 
       % for k=1:size(points)
           % plot3(points(k,1).x,points(k,1).y,zc,'-s');
           % hold on
           % plot3(points(k,2).x,points(k,2).y,zc,'-s');
           % hold on
        %end
end
