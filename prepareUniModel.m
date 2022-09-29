function [f_min,f,empiricalParam]=prepareUniModel(x,y,x_plot,selectedModel,optimMethod)
   f_min=0;f=0;
   %Choosing retention model...
   selectedModel
   switch (selectedModel)
     case 1 %Equation 1
       f=@(x,p)p(1).*exp(-x.*p(2));
       coef=flip(polyfit(x,log(y),1));
       empiricalParam(1)=exp(coef(1)); empiricalParam(2)=-coef(2);
       lim=limits(empiricalParam);
       if (optimMethod==1)
         f_min=@(x,p) p(1).*exp(-x.*p(2));
       else
         f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel)
       endif
       case 2 %Equation 2
       f=@(x,p) p(1).*exp(-x.*p(2)+p(3).*(x.^2));
       coef=flip(polyfit(x,log(y),2));
       empiricalParam(1)=exp(coef(1)); empiricalParam(2)=-coef(2); empiricalParam(3)=coef(3);
       lim=limits(empiricalParam);
       if (optimMethod==1)
         f_min=@(x,p)p(1).*exp(-x.*p(2)+p(3).*x.^2);
       else
         f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
       endif
       case 3 %Equation 3
      f=@(x,p) p(1).*exp(-p(2).*(x./(1+p(3).*x)));
      coef=flip(polyfit(x,log(y),2));
      empiricalParam(1)=exp(coef(1)); empiricalParam(2)=-coef(2); empiricalParam(3)=-coef(3)/coef(2);
      lim=limits(empiricalParam);
      if (optimMethod==1)
        f_min=@(x,p) p(1).*exp(-p(2).*(x./(1+p(3).*x)));
      else
        f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
      case 4 %Equation 4
      f=@(x,p) [p(1).*(1+p(3).*x).^2].*exp(-(p(2).*(x./(1+p(3).*x))));
      coef=flip(polyfit(x,log(y),2));
      empiricalParam(1)=exp(coef(1)); empiricalParam(2)=-coef(2); empiricalParam(3)=-coef(3)/coef(2);
      %lim=limits(empiricalParam);
      lim=[-1 300;
            0 5000;
            0 50000];
      if (optimMethod==1)
        f_min=@(x,p) [p(1).*(1+p(3).*x).^2].*exp(-(p(2).*(x./(1+p(3).*x))));
      else
        f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
      case 5 %Equation 5
      f=@(x,p) (p(1).*x).^(-p(2));
      coef=polyfit(x,(1./y),1);
      empiricalParam(1)=coef(1); empiricalParam(2)=1;
      lim=limits(empiricalParam);
      if (optimMethod==1)
        f_min=@(x,p) (p(1).*x).^(-p(2));
      else
        f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
     case 6 %Equation 6
      f=@(x,p) (p(1)+p(2).*x).^(-p(3));
      coef=flip(polyfit(x,(1./y),1))
      empiricalParam(1:2)=coef; empiricalParam(3)=1;
      lim=limits(empiricalParam);
      if (optimMethod==1)
       f_min=@(x,p) (p(1)+p(2).*x).^(-p(3));
      else
       f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
      case 7 %Equation 7
      f=@(x,p) p(1)./[(1+(p(3)-1)*p(2)*exp([p(3)-1]*log(p(1))).*x).^(1/(p(3)-1))];
      coef=polyfit(x,log(y),1);
      empiricalParam(1)=exp(coef(1)); empiricalParam(2)=-coef(2);empiricalParam(3)=1.1;
      lim=limits(empiricalParam);
      if (optimMethod==1)
        f_min=@(x,p) p(1)./[(1+(p(3)-1).*p(2).*x.*exp((p(3)-1).*log(p(1)))).^(1./(p(3)-1))];
      else
        f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
      case 8 %Equation 8
      f=@(x,p)[p(1)]./(1+p(2).*x);
      coef=flip(polyfit(x,1./y,1));
      empiricalParam(1)=1/coef(1);empiricalParam(2)=coef(2)*empiricalParam(1);
      lim=limits(empiricalParam);
      if (optimMethod==1)
         f_min=@(x,p) p(1)./(1+p(2).*x);
      else
         f_min=@(p)f_bounded_powell_nm(p,x,y,lim,selectedModel);
      endif
      otherwise
      msgbox("An error ocurred in the selection of the model.");
    endswitch
  close;
  end
