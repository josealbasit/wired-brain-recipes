function plotOptimization(X,Y,f,paramMatrix,pos)
   m=(size(paramMatrix)(1)-2)/2;
   optimParam=paramMatrix(m+1:2*m,:)
   n=size(X)(2);%Number of solutes
   point=zeros(0,2);
   keepX=ones(size(X));
   if(n==1)
   j=1;%number of rows
   k=1;%number of columns
   elseif(n==2)
   j=1;
   k=2;
   elseif(n>2 && rem(n,2)==1)
   j=2;
   k=(n+1)/2;
   elseif(n>2 && rem(n,2)==0)
   j=2;
   k=n/2;
 endif
 figure(1,"position",get(0,"screensize")([3,4,3,4]).*[0 0.1 0.9 0.8])
   for i=1:n
    l=pos(i);
    x=X(1:end-l,i);
    y=Y(1:end-l,i);
    eps=(x(end)-x(1))/8;
    x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
    y_optim_plot=f(x_plot,optimParam(:,i));
    ax(i)=subplot(j,k,i);
    plot(x,y,'go','DisplayName','Experimental Retention Data')
    hold on
    plot(x_plot,y_optim_plot,'b','DisplayName','Optimized approximation')
    legend show;
    title(["Optimization for solute " num2str(i)]);
   end
   %S  = axes( 'visible', 'off', 'title', 'Select retention data to be removed.','position' );
      disp("Select retention data to be removed by clicking close to it on each plot. When you're done, press any key to continue!")
      counter=1;
      finish=false;
   while(finish==false && counter<(6*n+1))
      [x_coord,y_coord,button]=ginput(1);
   if(button==2)
      finish=true;%Selection process is terminated
   endif
      [~, axnum] = ismember(gca, ax);%Selected axis
      position=returnClosest(X(:,axnum),x_coord);%Position of the closest value
      [c,~]=find(point==axnum)%Previous click in this plot
      [d,~]=find(point==position) %Previoous position in certain plot
      e=intersect(c,d);
      point=[point; [axnum position]];
    if(isempty(e)==false)%If we have already selected that point, then unclick it
      subplot(j,k,axnum);
      hold on;
      plot(X(position,axnum),Y(position,axnum),'go');
      keepX(position,axnum)=0;
    else(isempty(e)==true)
      subplot(j,k,axnum)
      hold on;
      plot(X(position,axnum),Y(position,axnum),'ro'); 
      keepX(position,axnum)=1;
    endif
      counter=counter+1;
    endwhile
    keepX
    waitforbuttonpress();
endfunction
