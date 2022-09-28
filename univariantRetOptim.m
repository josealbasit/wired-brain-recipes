function [bestParam,x,y,f,D]=univariantRetOptim(xRaw,yRaw,x_plot,iterRandom,selectedModel,optimMethod)
   [x,y]=checkNaN(xRaw,yRaw);
   [f_min,f,empiricalParam]=prepareUniModel(x,y,x_plot,selectedModel,3) %Choosing retention model...
   l=2*length(empiricalParam)+2;
   B=zeros(iterRandom,l);%This matrix will store different initial and optim Parameters along with their associated optimization results: relative error and R^2.
   C=zeros(iterRandom,l);
   D=zeros(0,0);
   %For non lineal convertible equations.
   if(or(selectedModel == 4,selectedModel == 5,selectedModel == 6,selectedModel == 7))
   randomParameters=generateRandomParameters(empiricalParam,iterRandom)
   for i=1:iterRandom
    initParam=randomParameters(:,i)';
    [optimParam r2 errorOptim]=optimizationProcess(x,y,f_min,f,initParam,3);
    r=rand;
    if(r>.90)
    retentionUniPlot(x,y,x_plot,f,initParam,optimParam,1); %Plotting results...
  end
    B(i,:)=[initParam(:)' optimParam(:)' errorOptim r2]; %Storing optimized values
   endfor
   rndOptimError=find(B(:,l-1)==min(B(:,l-1)));
   t=(l-2)/2;
   estimParam=B(rndOptimError,t+1:2*t)';
   else
   estimParam=empiricalParam';
   endif
   estimParameters=generateEstimParameters(estimParam,iterRandom);
   for j=1:3
    optimMethod=j;
    [f_min,f,empiricalParam]=prepareUniModel(x,y,x_plot,selectedModel,optimMethod); %Choosing retention model...
    for i=1:iterRandom
      initParam=estimParameters(:,i);
      [optimParam r2 errorOptim]=optimizationProcess(x,y,f_min,f,initParam,optimMethod)
      r=rand();
      if (r>.9)
      retentionUniPlot(x,y,x_plot,f,initParam,optimParam,1); %Plotting results...
    end
      C(i,:)=[initParam(:)' optimParam(:)' errorOptim r2]; %Storing optimized values
    endfor
    D=[D;C];
   endfor
   posOptimError=find(D(:,l-1)==min(D(:,l-1)));
   if(posOptimError>1)
   posOptimError=find(D(posOptimError,l)==max(D(posOptimError,l)));
   end
   bestParam=D(posOptimError,:)';
 end

