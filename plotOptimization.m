function plotOptimization(X,Y,f,paramMatrix,pos)
   m=(size(paramMatrix)(1)-2)/2;
   optimParam=paramMatrix(m+1:2*m,:)
   n=size(X)(2);%Number of solutes
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
   for i=1:n
    l=pos(i);
    x=X(1:end-l,i);
    y=Y(1:end-l,i);
    eps=(x(end)-x(1))/8;
    x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
    y_optim_plot=f(x_plot,optimParam(:,i));
    ax(i)=subplot(j,k,i);
    plot(x,y,'o','DisplayName','Experimental Retention Data')
    hold on
    plot(x_plot,y_optim_plot,'r','DisplayName','Optimized approximation')
    legend show;
    title(["Optimization for solute " num2str(i)]);
   end
   %S  = axes( 'visible', 'off', 'title', 'Select retention data to be removed.','position' );
   disp("Select retention data to be removed by clicking close to it on each plot. When you're done, press any key to continue!")
   counter=1;
   finish=false;
   while(finish==false && counter<(3*n+1))
    [x_coord,y_coord,button]=ginput(1);
   if(button==2)
    finish=true;%Selection process is terminated
   endif
    [~, axnum] = ismember(gca, ax);
    updatePlot()
    A(counter,:)=[x_coord y_coord axnum];
    counter=counter+1;
   endwhile
   waitforbuttonpress();
endfunction
