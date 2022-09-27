function main()
  packages(); %Loading forge packages...
  selectNewData=true;
  while (selectNewData==true) %While we want to optimize new data...
    [modelType,changeRetModel,selectNewData,counterModel,compound,counterData,bestError,optimMethod,optimData,solutes] = mainConstants(); %Initial constants...
    [initialDir, desktopDir]=directories(); %Directories...
    while (modelType == 0)
      [fileName, filePath]=introRetentionData(desktopDir); %Get file name and path...
      addpath(filePath); %Add current file path
      A=loadFile(fileName) %Loading file to the system...
      modelType=checkRetData(A); %Checking which models we can use, i.e, dimension of the matrix...
    endwhile
%Until now, we have selected the data file. Now we need an equation to model the data and an optimization method to
%optimize parameters.
    while (changeRetModel == true)
    selectedModel=chooseModel(modelType);
    %optimMethod=menu("Select an optimization method:","Levenberg-Marquadt","Nelder-Mead","Powell");
    solutesRaw=separateSolutes(A,modelType)
    solutesRaw
    n=size(solutesRaw)(1)
    if(modelType==1)
         [xRaw,x_plot,iterRandom] = defOptimConstUni(A);
         for i=1:size(solutesRaw)(2)
           [bestParam,x,y,f,D]=univariantRetOptim(xRaw,solutesRaw(:,i),x_plot,iterRandom,selectedModel,optimMethod);
           paramMatrix(:,i)=bestParam(:)';
           [data,l]=prepareComparation(n,f,y,D)
           optimData(:,:,i)=data;
           pos(i)=l;
           X(:,i)=[x(:)' zeros(1,l)];
           Y(:,i,1)=[y(:)' zeros(1,l)];

         endfor
         comparation(n,optimData,pos);
         plotErrorMatrix(optimData,pos);
         plotOptimization
    elseif(modelType==2)
      for i=1:size(solutesRaw)(2)
         [xRaw,X,Y,iterRandom] = defOptimConstBi(A); %Defining constants for optimization calculation and plotting...
         [bestParam x z f D]=bivariantRetOptim(xRaw,solutesRaw(:,i),X,Y,iterRandom,selectedModel,optimMethod);
         paramMatrix(:,i)=bestParam';
         [data,l]=prepareComparation(n,f,z,D);
         optimData(:,:,i)=data;
         pos(i)=l;
      endfor
      comparation(n,optimData,pos);
      plotErrorMatrix(optimData,pos);
      plotOptimization
    endif
    paramMatrix
    answer=questdlg("Do you want to enter a MANUAL estimation of initial parameters and perform an optimization?");
    if (length(answer)== 3)
      manualParam=manualParameters(A,selectedModel,modelType,paramMatrix(:,i));
      bestParam=manualOptimization(A,manualParam,selectedModel,modelType);
    endif
    whatNext=menu("Select an option!"," Change retention model ", "Select new data" , "Close program"); %What to do next....
    switch (whatNext)
      case 1 %Change retention model using the same data...
        close all;
        counterModel=counterModel+1;
        clear paramMatrix;
      case 2 %Change data and start again...
        changeRetModel=false;
        counterModel=0;
        close all;
      case 3 %Close program...
        changeRetModel=false;
        selectNewData=false;
        close all;
        msgbox("Bye bye! Ens veiem!");
    endswitch
    endwhile
  endwhile
end
