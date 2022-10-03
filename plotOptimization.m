function [Xnew,Ynew,keepX,out]=plotOptimization(X,Y,f,f_plot,paramMatrix,pos)
   out=false;
   removeData=true;
   m=(size(paramMatrix)(1)-2)/2;
   optimParam=paramMatrix(m+1:2*m,:)
   n=size(X)(2);%Number of solutes
   point=zeros(0,2);
   keepX=ones(size(xRaw));
   solLabels=cell(n,1);
   for i=1:n
     solLabels{i,1}= ["Solute " num2str(i)];
   endfor
   while(removeData==true)
   R=menu("Remove data from:",solLabels);
   h=figure(1,"position",get(0,"screensize")([3,4,3,4]).*[0 0.1 0.9 0.8])
   subplot(2,1,1)
   contourf(X,Y,f_plot(optimParam(:,R)));
   hold on
   scatter3(xRaw(:,1),xRaw(:,2),z, 'r+')
   subplot(2,1,2)
   surf(X,Y,f_plot(optimParam(:,R)));
   title("Select data from left-hand side plot to perform new optimization");


   endwhile



   for i=1:n
    l=pos(i);
    keepX(end-l+1:end,i)=NaN;
    x=X(1:end-l,i);
    y=Y(1:end-l,i);
    eps=(x(end)-x(1))/8;
    x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
    y_optim_plot=f(x_plot,optimParam(:,i));
    ax(i)=subplot(j,k,i);
    h1=plot(x,y,'go');
    hold on
    h2=plot(x_plot,y_optim_plot,'b');
    if (i==1)
       legend ([h1 h2],"Experimental Retention Data","Optimized approximation");
    endif
    title(["Solute " num2str(i)]);
   end
   S= axes('visible', 'off', 'title', 'Select data to remove',"fontsize",18,"fontweight","bold");
      disp("Select retention data to be removed by clicking close to it on each plot. When you're done, press any key to continue!")
      counter=1;
      finish=false;
   while(finish==false && counter<(6*n+1))
      [x_coord,y_coord,button]=ginput(1);
   if(button==3)
      finish=true;%Selection process is terminated
   elseif(button==1)
      [~, axnum] = ismember(gca, ax);%Selected axis
      position=returnClosest(X(1:end-pos(axnum),axnum),x_coord); %Position of the closest value without taking into account zero values
    if(keepX(position,axnum)==1)%If we have already selected that point, then unclick it
      subplot(j,k,axnum);
      hold on;
      plot(X(position,axnum),Y(position,axnum),'ro');
      keepX(position,axnum)=0;
    else(keepX(position,axnum)==0)
      subplot(j,k,axnum)
      hold on;
      plot(X(position,axnum),Y(position,axnum),'go');
      keepX(position,axnum)=1;
    endif
      S=axes('visible', 'off', 'title', 'Select data to remove',"fontsize",18,"fontweight","bold");
      counter=counter+1;
    endif
  endwhile
    Xnew=X.*keepX;
    Ynew=Y.*keepX;
    if(isempty(keepX(keepX==0)))
      out=true;
    else
      Xnew(Xnew==0)=NaN; %Now we perform the loop again
      Ynew(Ynew==0)=NaN;
      w=zeros(0,0);
      for(i=1:n)
        l=pos(i);
        if(sum(isnan(Xnew(1:end-l,i)))==0)
          w=[w i];
        endif
      end
      Xnew(:,w)=[];
      Ynew(:,w)=[];
   endif
endfunction
