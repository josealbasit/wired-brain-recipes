function [Xnew,Znew,keepX,out,numberSol]=plotOptimization(X,Z,Xall,Zall,f,f_plot,paramMatrix,pos,numberSol)
   finish=false;
   out=false;
   counter=0;
   removeData=true;
   m=(size(paramMatrix)(1)-2)/2;
   optimParam=paramMatrix(m+1:2*m,:);
   Rsquared=paramMatrix(end,:);
   n=size(Zall)(2);%Number of solutes
   point=zeros(0,2);
   w=zeros(0,0);
   keepX=ones(size(Xall(:,:,1)))
   solLabels=cell(n+1,1);
   for i=1:n
     solLabels{i,1}= ["Solute " num2str(numberSol(i))];
   endfor
   solLabels{n+1,1}="None. Finish selection";
   while(removeData==true)
   R=menu("Remove data from:",solLabels);
   if(R!=n+1)
   finish=false;
   counter=0;
   reds=find(keepX(:,R)==0);
   clf
   h=figure(1,"position",get(0,"screensize")([3,4,3,4]).*[0 0.1 0.9 0.8])
   subplot(2,1,1)
   contourf(X,Z,f_plot(optimParam(:,R)));
   title(["Select data to remove from upper plot to perform new optimization for solute " num2str(numberSol(R))]);
   hold on
   plot(Xall(1:end-pos(R),R,1),Xall(1:end-pos(R),R,2),'gd')
   plot(Xall(1:end-pos(R),R,1),Xall(1:end-pos(R),R,2),'g.')
   plot(Xall(1:end-pos(R),R,1)(reds),Xall(1:end-pos(R),R,2)(reds),'rd')
   plot(Xall(1:end-pos(R),R,1)(reds),Xall(1:end-pos(R),R,2)(reds),'r.')
   subplot(2,1,2)
   surf(X,Z,f_plot(optimParam(:,R)));
   hold on
   scatter3(Xall(:,R,1),Xall(:,R,2),Zall(:,R), 'filled')
   title(["R^2= " num2str(Rsquared(R))]);
    while(finish==false && counter<(6*n+1))
      [x_coord,y_coord,button]=ginput(1)
      if(button==3)
      finish=true;
      elseif(button==1)
      position=returnClosest(Xall(:,R,1),x_coord)
      if(length(position)>1)
        pos2=returnClosest(Xall(position,R,2),y_coord)
        position=position(pos2)
      endif
        if(keepX(position,R)==1)%If we have already selected that point, then unclick it
        subplot(2,1,1)
        hold on;
        plot(Xall(position,R,1),Xall(position,R,2),'rd');
        plot(Xall(position,R,1),Xall(position,R,2),'r.');
        keepX(position,R)=0;
        else(keepX(position,R)==0)
        subplot(2,1,1)
        hold on;
        plot(Xall(position,R,1),Xall(position,R,2),'gd');
        plot(Xall(position,R,1),Xall(position,R,2),'g.');
        keepX(position,R)=1;
        endif
      endif
    endwhile
   elseif(R==n+1)
      removeData=false;
   endif
 endwhile
    if(isempty(keepX(keepX==0)))
      out=true;
    end
    keepX(keepX==0)=NaN;
    for i=1:n
        l=pos(i);
        if(sum(isnan(keepX(1:end-l,i)))==0)
          w=[w i];
        endif
    end
    numberSol(w)=[];
    Xnew(:,:,1)=Xall(:,:,1).*keepX;
    Xnew(:,:,2)=Xall(:,:,2).*keepX;
    Xnew(:,w,:)=[]
    Znew=Zall.*keepX;
    Znew(:,w,:)=[]
    endfunction
