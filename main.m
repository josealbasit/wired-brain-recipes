function [B]=main()
  packages(); %Loading forge packages...
  selectNewData=true;
  while (selectNewData==true) %While we want to optimize new data...
    [modelType,changeRetModel,selectNewData,counterModel,compound,counterData,bestError,optimMethod,optimData,solutes,removeData] = mainConstants(); %Initial constants...
    paramMatrix=zeros(0,0);
    [initialDir, desktopDir]=directories(); %Directories...
    while (modelType == 0)
      [fileName, filePath]=introRetentionData(desktopDir); %Get file name and path...
      addpath(filePath); %Add current file path
      A=loadFile(fileName) %Loading file to the system...
      modelType=checkRetData(A); %Checking which models we can use, i.e, dimension of the matrix...
    endwhile
%Until now, we have selected the data file. Now we need an equation to model the data and an optimization method to
%optimize parameters.
    while (changeRetModel==true)
    selectedModel=chooseModel(modelType);
    solutesRaw=separateSolutes(A,modelType);
    n=size(solutesRaw)(1)
    numberSol=1:n;
    if(modelType==1)
         [xRaw,iterRandom]=defOptimConstUni(A);
         for i=1:size(solutesRaw)(2)
           [bestParam,x,y,f,D]=univariantRetOptim(xRaw,solutesRaw(:,i),iterRandom,selectedModel,optimMethod);
           paramMatrix(:,i)=bestParam(:)';%Matrix containing different parameters of the optimized values.
           [data,l]=prepareComparation(n,f,x,y,D);
           optimData(:,:,i)=data;
           pos(i)=l;
           Xall(:,i)=[x(:)' nan(1,l)];
           Yall(:,i,1)=[y(:)' nan(1,l)];
         endfor
         B.autoOptimization=paramMatrix;
         comparation(n,optimData,pos);
         plotErrorMatrix(optimData,pos);
         [Xnew,Ynew,keepX,out]=plotUniOptimization(Xall,Yall,f,paramMatrix,pos);
         counterRem=1;%Counter for removed data cycles
         while(out==false) %User has selected points to remove and perform optimization
            [m,n]=size(Xnew);
            clear Xall Yall optimData2 pos2
            for i=1:n
                [bestParam,x,y,f,D]=univariantRetOptim(Xnew(:,i),Ynew(:,i),iterRandom,selectedModel,optimMethod);
                B.autoRemovedOptimization(:,i,counterRem)=bestParam';
                [data2,l2]=prepareComparation(m,f,x,y,D);
                Xall(:,i)=[x(:)' nan(1,l2)];
                Yall(:,i,1)=[y(:)' nan(1,l2)];
                optimData2(:,:,i)=data2;
                pos2(i)=l2;
            endfor
         comparation(m,optimData2,pos2,numberSol);
         plotErrorMatrix(optimData2,pos2);
         [Xnew,Ynew,keepX,out]=plotUniOptimization(Xall,Yall,f,B.autoRemovedOptimization(:,:,counterRem),pos2);
         counterRem=counterRem+1;
         endwhile
         %Here data should be saved in case removing points is not helpful for optimization improvement
    elseif(modelType==2)
      for i=1:size(solutesRaw)(2)
         [xRaw,X,Z,iterRandom] = defOptimConstBi(A); %Defining constants for optimization calculation and plotting...
         [bestParam x z f f_plot D]=bivariantRetOptim(xRaw,solutesRaw(:,i),X,Z,iterRandom,selectedModel,optimMethod);
         paramMatrix(:,i)=bestParam';
         [data,l]=prepareComparation(n,f,x,z,D);
         Xall(:,i,1)=[x(:,1)' nan(1,l)];%Concentration
         Xall(:,i,2)=[x(:,2)' nan(1,l)];%Additive
         Zall(:,i)=[z(:)' nan(1,l)];
         optimData(:,:,i)=data;
         pos(i)=l;
      endfor
      B.autoOptimization=paramMatrix
      comparation(n,optimData,pos,numberSol);
      plotErrorMatrix(optimData,pos);
      [Xnew,Znew,keepX,out,numberSol]=plotOptimization(X,Z,Xall,Zall,f,f_plot,paramMatrix,pos,numberSol);
      counterRem=1;%Counter for removed data cycles
      while(out==false)
      m=size(Xnew)(1)
      n=size(Xnew)(2)
      Xnew %Here we havent changed the NaN in the solutes, but only the ones selected are used
      clear Xall Zall optimData pos paramMatrix
      for i=1:n
         [xRaw,X,Z,iterRandom] = defOptimConstBi([Xnew(:,i,1)(:) Xnew(:,i,2)(:)]); %Defining constants for optimization calculation and plotting...
         [bestParam x z f f_plot D]=bivariantRetOptim(xRaw,Znew(:,i),X,Z,iterRandom,selectedModel,optimMethod);
         paramMatrix(:,i)=bestParam';
         [data,l]=prepareComparation(m,f,x,z,D);
         Xall(:,i,1)=[x(:,1)' nan(1,l)];%Concentration
         Xall(:,i,2)=[x(:,2)' nan(1,l)];%Additive
         Zall(:,i)=[z(:)' nan(1,l)];
         optimData(:,:,i)=data;
         pos(i)=l;
      endfor
      B.autoRemovedOptimization=paramMatrix
      comparation(m,optimData,pos);
      plotErrorMatrix(optimData,pos);
      [Xnew,Znew,keepX,out,numberSol]=plotOptimization(X,Z,Xall,Zall,f,f_plot,paramMatrix,pos,numberSol);
      counterRem=1;%Counter for removed data cycles
      endwhile
    endif
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
        clear all;
        changeRetModel=false;
        counterModel=0;
        selectNewData=true;
        packages();
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
