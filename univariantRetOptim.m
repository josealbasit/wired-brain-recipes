function [bestParam,x,y,f,D]=univariantRetOptim(xRaw,yRaw,iterRandom,selectedModel,optimMethod)
   [x,y,x_plot]=checkNaN(xRaw,yRaw);
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
   rndOptimError=find(B(:,l)==max(B(:,l)))
   t=(l-2)/2;
   if(rndOptimError>1)
   rndOptimError=find(B(rndOptimError,l-1)==min(B(rndOptimError,l-1)));
   end
   estimParam=B(rndOptimError(1),t+1:2*t)'
   else
   estimParam=empiricalParam(:)';
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
   D
   posOptimError=find(D(:,l)==max(D(:,l)))
   if(posOptimError>1)
   posOptimError=find(D(posOptimError,l-1)==min(D(posOptimError,l-1)));
   end
   bestParam=D(posOptimError(1),:)';
 end

