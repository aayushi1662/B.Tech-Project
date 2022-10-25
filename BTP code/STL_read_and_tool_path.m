clear all;
clc;
%Open STL file
fid=fopen('pp.stl');
%Reading First Line
a1=fgetl(fid);
%Assigning standard strings to variables
fn='facet normal';
v='vertex';
normal=[];
vertex=[];
while ~ischar(a1)==0
    if strfind(a1,fn) ~= 0 %Condition check for Facet Normal
        a=sscanf(a1,'%*s %*s %f %f %f'); %Saving Facet Normal Values
        normal=[normal;a']; %Stack up Facet Normal values
    elseif strfind(a1,v) ~= 0 %Condition check
        a=sscanf(a1,'%*s %f %f %f'); %Saving Vertex // a stores integer values in column wise--- a' use to make row and stored in vertex horizontally
        
        vertex=[vertex;a']; %Stack up Vertex values
    end
    a1=fgets(fid); %Read next line from file
end
fclose(fid); %Close the file
m=size(vertex); %Saving size of vertex in 'm'
%for i=1:m
    %a1=[];
   % if mod(i,3)==0
        %Plotting Triagles by saving co-ordinates
        %a1=[vertex(i-2,:);vertex(i-1,:);vertex(i,:);vertex(i-2,:)]; 
       % fill3(a1(:,1),a1(:,2),a1(:,3),'c','facealpha',0.5);
       % xlabel('x')
        %ylabel('y')
        %zlabel('z')
      % hold on;
   % end
%end

vertex=reorder(vertex,normal);
slice_height=50;
maxz=max(vertex(:,3));
   minz=min(vertex(:,3)); 
 %for zc=minz+25:30:maxz-20
 zc=maxz-20;
       [list_of_trinagles,n]=slicing(vertex,slice_height,zc,normal);
      [points,loop1,n]= intersection(list_of_trinagles,zc,n);
     %loops=contour_construction(points,zc);
    l1=points;
   
    xmin=(min(vertex(:,1))-20); xmax= (max(vertex(:,1))+20); ymin=(min(vertex(:,2))-20);ymax=(max(vertex(:,2))+20);
    xtotal={};ytotal={};ztotal={};
 step=1.7;
 n=1;
 for ystep=ymin:step:ymax
     X=[xmin]; Y={}; zplot={}; 
     for i=1:size(l1)
     u =((ystep)-l1(i,1).y)/(l1(i,2).y-l1(i,1).y);
     if(u>=0 && u<=1)
         xinter=l1(i,1).x+u*(l1(i,2).x-l1(i,1).x);
         X=[X,(xinter)]; 
         
     end
     end
 X=[X,xmax];
 sort(X);
 X=unique((X)); 
 Y=ystep*ones(size(X));
 zplot=zc*ones(size(X));
 s=size(X);
 c=1;l=0;
 if( mod(n,2)~=0)    
 for j=1:s(1,2)-1
     if mod(c,2)~=0
         if(l==1)
             ux=[xplot(end),X(1,j)];
         uy= [yplot(end),Y(1,j)];
         uz= [maxz,zc];
         xtotal=[xtotal,ux];
         ytotal=[ytotal,uy];
         ztotal=[ztotal,uz];
         %plot3(ux,uy,uz,'b');
         l=0;
         end
   xplot=[X(1,j),X(1,j+1)];
   yplot=[Y(1,j),Y(1,j+1)];
   zplot=zc*ones(size(xplot));
   xtotal=[xtotal,xplot];
         ytotal=[ytotal,yplot];
         ztotal=[ztotal,zplot];
   %plot3(xplot,yplot,zplot,'b');
  %plot(xplot,yplot,'b');
   hold on
   xlabel('x')
    ylabel('y')
     zlabel('z')
     else
         l=1;
         ux=[xplot(end),X(1,j)];
         uy= [yplot(end),Y(1,j)];
         uz= [zc,maxz];
         xtotal=[xtotal,ux];
         ytotal=[ytotal,uy];
         ztotal=[ztotal,uz];
         %plot3(ux,uy,uz,'b');
    xplot=[X(1,j),X(1,j+1)];
   yplot=[Y(1,j),Y(1,j+1)];
   zplot=maxz*ones(size(xplot));
   xtotal=[xtotal,xplot];
         ytotal=[ytotal,yplot];
         ztotal=[ztotal,zplot];
   %plot3(xplot,yplot,zplot,'b');
     end 
      c=c+1;
 end
 
 ax=[X(end),X(end)];
 ay=[ystep,ystep+step];
az=zc*ones(size(ax));
xtotal=[xtotal,ax];
         ytotal=[ytotal,ay];
         ztotal=[ztotal,az];
 %plot3(ax,ay,az,'b');
%plot(ax,ay,'b');
 hold on
 end
 if(mod(n,2)==0)
    for k=s(1,2):-1:2
     if mod(c,2)~=0
         if(l==1)
             ux=[xplot(end),X(1,k)];
         uy= [yplot(end),Y(1,k)];
         uz= [maxz,zc];
          xtotal=[xtotal,ux];
         ytotal=[ytotal,uy];
         ztotal=[ztotal,uz];
         %plot3(ux,uy,uz,'b');
         l=0;
         end
   xplot=[X(1,k),X(1,k-1)];
   yplot=[Y(1,k),Y(1,k-1)];
   zplot=zc*ones(size(xplot));
   xtotal=[xtotal,xplot];
         ytotal=[ytotal,yplot];
         ztotal=[ztotal,zplot];
   %plot3(xplot,yplot,zplot,'b');
  %plot(xplot,yplot,'b');
   hold on
   xlabel('x')
    ylabel('y')
     zlabel('z')
     else
         
         l=1;
         ux=[xplot(end),X(1,k)];
         uy= [yplot(end),Y(1,k)];
         uz= [zc,maxz];
         xtotal=[xtotal,ux];
         ytotal=[ytotal,uy];
         ztotal=[ztotal,uz];
        % plot3(ux,uy,uz,'b');
         xplot=[X(1,k),X(1,k-1)];
   yplot=[Y(1,k),Y(1,k-1)];
   zplot=maxz*ones(size(xplot));
   xtotal=[xtotal,xplot];
         ytotal=[ytotal,yplot];
         ztotal=[ztotal,zplot];
  % plot3(xplot,yplot,zplot,'b');
     end 
      c=c+1;
    end
 ax=[X(1),X(1)];
 ay=[ystep,ystep+step];
 az=zc*ones(size(ax));
 xtotal=[xtotal,ax];
         ytotal=[ytotal,ay];
         ztotal=[ztotal,az];
 %plot3(ax,ay,az,'b');
%plot(ax,ay,'b');
 hold on
 end
 n=n+1;
 hold on
 end 
 axis([xmin-10 xmax+10 ymin-10 ymax+10 minz-10 maxz+10])
 % For Animation purpose
 %v=VideoWriter('toolpath3.avi');
  % v.FrameRate=10;
   %open(v)
   %s=size(xtotal);
   %xtotal=cell2mat(xtotal);
 %ytotal=cell2mat(ytotal);
 %ztotal=cell2mat(ztotal);
  % for i=1:s(1,2)*2     
 %plot3(xtotal(1:i),ytotal(1:i),ztotal(1:i),'b');
 %hold on
 %xlabel('x')
 %ylabel('y')
 %zlabel('z')
 %axis([xmin-10 xmax+10 ymin-10 ymax+10 minz-10 maxz+10])
 %frame=getframe(1);
 %writeVideo(v,frame);
%pause(.0001); 
 %end
 %close(v)
 