selectedModel=1;
x=[0.1 0.13 0.15 0.17 0.2 0.3];
eps=(x(end)-x(1))/8;
x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
y0=[3.2602   2.5058   2.1296   1.8267   1.4746   0.8101];
y=y0;
f=@(p) p(1).*exp(-x.*p(2)+p(3).*(x.^2));
f_plot=@(p) p(1).*exp(-x_plot.*p(2)+p(3).*(x_plot.^2));
coef=flip(polyfit(x,log(y),2));
empiricalParam(1)=exp(coef(1)); empiricalParam(2)=-coef(2); empiricalParam(3)=coef(3);
f_min=@(x,p)p(1).*exp(-x.*p(2)+p(3).*x.^2);
initParam=empiricalParam;


%selectedModel=2;
%x=[0.1 0.13 0.15 0.17 0.2 0.3];
%eps=(x(end)-x(1))/8;
%%x_plot=linspace(x(1)-eps,x(end)+eps,100); %x coordinate to plot discrete data
%y0=[3.2602   2.5058   2.1296   1.8267   1.4746   0.8101];
%y=y0;
%f=@(p) p(1).*exp(-x.*p(2));
%f_plot=@(p) p(1).*exp(-x_plot.*p(2));
%coef=flip(polyfit(x,log(y),2));
%empiricalParam(1)=exp(coef(1)); empiricalParam(2)=-coef(2);
%f_min=@(x,p)p(1).*exp(-x.*p(2));
%initParam=empiricalParam;
