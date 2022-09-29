function [x,y,x_plot,x1,x2,w]=checkNaN(xRaw,yRaw)
  B=isnan(yRaw);
  a=find(B==0);
  x=xRaw(a,:);
  y=yRaw(a);
  x1=0;x2=0;w=0;
  eps=(x(end)-x(1))/8;
  x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
  if (size(x)(2)==2)
    x1=x(:,1);
    x2=x(:,2);
    w=repelem(1,length(x1));
  endif

  endfunction
