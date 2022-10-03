function [Xnew,Ynew,keepX,out]=plotOptimization(X,Y,Xall,Zall,f,f_plot,paramMatrix,pos)
   out=false;
   removeData=true;
   m=(size(paramMatrix)(1)-2)/2;
   optimParam=paramMatrix(m+1:2*m,:)
   n=size(X)(2);%Number of solutes
   point=zeros(0,2);
   keepX=ones(size(Xall(:,:,1)));
   solLabels=cell(n+1,1);
   for i=1:n
     solLabels{i,1}= ["Solute " num2str(i)];
   endfor
   solLabels{n+1,1}="None. Finish selection";
   while(removeData==true)
   R=menu("Remove data from:",solLabels);
   if(R!=n+1)
   h=figure(1,"position",get(0,"screensize")([3,4,3,4]).*[0 0.1 0.9 0.8])
   subplot(2,1,1)
   contourf(X,Y,f_plot(optimParam(:,R)));
   hold on
   plot(Xall(:,R,1),Xall(:,R,2),'gd')
   plot(Xall(:,R,1),Xall(:,R,2),'g.')
   subplot(2,1,2)
   surf(X,Y,f_plot(optimParam(:,R)));
   hold on
   scatter3(Xall(:,R,1),xRaw(:,R,2),Zall(:,R), 'r+')
   title("Select data from left-hand side plot to perform new optimization");
   [x_coord,y_coord,button]=ginput(1);
   position=returnClosest(Xall(:,R,1),x);
   if(keepX(position,R)==1)%If we have already selected that point, then unclick it
      subplot(2,2,1)
      hold on
      plot(Xall(position,R,1),Xall(position,R,2),'rd');
      keepX(position,R)=0;
    else(keepX(position,R)==0)
      subplot(2,2,1)
      hold on
      plot(X(position,R),Xall(position,R),'gd');
      keepX(position,R)=1;
   endif
   elseif(R==n+1)
      removeData=false;
   endif
 endwhile
   xNew(:,:,1)=Xall(:,:,1).*keepX;
   xNew(:,:,2)=Xall(:,:,2).*keepX;
   zNew(:,:)=Zall.*keepX;
endfunction
