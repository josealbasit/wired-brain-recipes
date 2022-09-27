function plotOptimization(X,Y,f,f_plot,paramMatrix)
   m=(size(paramMatrix)(1)-2)/2;
   optimParam=paramMatrix(m+1:2*m,:);
   for i=1:size(X)(2)
    x=X(:,i);
    y=Y(:,i);
    eps=(x(end)-x(1))/8;
    x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
    y_optim_plot=f_plot(optimParam(:,i));
    plot(x,y,'o')
    hold on
    plot(x_plot,y_optim_plot,'r')
   end
endfunction
