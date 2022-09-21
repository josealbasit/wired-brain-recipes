function [bestParam x z f D]=bivariantRetOptim(xRaw,zRaw,X,Y,iterRandom,selectedModel,optimMethod)
%This function uses Levenberg Marquadt,NelderMead and Powell methods to optimize parameters of
%diferent retention mathematical models. In this case, methods are bivariant, i.e, two
%variables are needed for retention estimation: these variables are a combination of surfactant and additives, depending on the case.
  [x,z,x1,x2,w]=checkNaN(xRaw,zRaw)
  x
  z
  [f_min,f_plot,f,empiricalParam]=prepareBiModel(x,x1,x2,z,w,X,Y,selectedModel,3);
  initialParameters=generateInitialParameters(empiricalParam,iterRandom);
  l=2*length(empiricalParam)+2;
  B=zeros(iterRandom,l);%This matrix will store different initial and optim Parameters along with their associated optimization results: relative error and R^2.
  C=zeros(iterRandom,l);
  D=zeros(0,0);
  %Now we generate random parameters
  randomParameters=generateRandomParameters(empiricalParam,iterRandom)
  empiricalParam
  for i=1:iterRandom
    initParam=randomParameters(:,i)';
    [optimParam r2 errorVector errorOptim]=optimizationProcess(x,z,f_min,f,initParam,3)
    r=rand;
    if (r>.3)
    retentionBiPlot(X,Y,f_plot,initParam,optimParam,1); %Plotting results...
    endif
    errorMatrix(i,:)=errorVector;
    B(i,:)=[initParam optimParam errorOptim r2]; %Storing optimized values
  endfor
  B
   rndOptimError=find(B(:,l-1)==min(B(:,l-1)));
   t=(l-2)/2; %Number of parameters
   estimParam=B(rndOptimError,t+1:2*t)'
   estimParameters=generateEstimParameters(estimParam,iterRandom)
   for j=1:3
   optimMethod=j;
   [f_min,f_plot,f,empiricalParam]=prepareBiModel(x,x1,x2,z,w,X,Y,selectedModel,optimMethod);
   for i=1:iterRandom
      initParam=estimParameters(:,i);
      [optimParam r2 errorVector errorOptim]=optimizationProcess(x,z,f_min,f,initParam,optimMethod);
      r=rand();
      if (r>.3)
      retentionBiPlot(X,Y,f_plot,initParam,optimParam,1); %Plotting results...
      endif
      errorMatrix(i,:)=errorVector;
      C(i,:)=[initParam' optimParam' errorOptim r2]; %Storing optimized values
    endfor
    D=[D;C]
    endfor
   posOptimError=find(D(:,l-1)==min(D(:,l-1)));
   bestParam=D(posOptimError,:)'
endfunction
