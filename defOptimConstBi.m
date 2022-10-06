function [x,X,Y,iter] = defOptimConstBi(A) %Creating constant needed for optimization...
  x=A(:,1:2);
  %p=isnan(A(:,1))
  %if(sum(p)==0)
  x_plot=linspace(A(:,1)(1),A(:,1)(end),75);
  y_plot=linspace(A(:,2)(1),A(:,2)(end),75);
  %elseif(sum(p)>0)
  %a=min(find(p==0))
  %b=max(find(p==0))
  %x_plot=linspace(A(:,1)(a),A(:,1)(b),75);
  %y_plot=linspace(A(:,2)(a),A(:,2)(b),75);
  %endif
  [X,Y]=meshgrid(x_plot,y_plot);
  iter=1;
end
