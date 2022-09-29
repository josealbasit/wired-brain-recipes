function main()
  packages(); %Loading forge packages...
  selectNewData=true;
  while (selectNewData==true) %While we want to optimize new data...
    [modelType,changeRetModel,selectNewData,counterModel,compound,counterData,bestError,optimMethod,optimData,solutes,removeData] = mainConstants(); %Initial constants...
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
    solutesRaw=separateSolutes(A,modelType);
    n=size(solutesRaw)(1)
    if(modelType==1)
         [xRaw,iterRandom]=defOptimConstUni(A);
         for i=1:size(solutesRaw)(2)
           [bestParam,x,y,f,D]=univariantRetOptim(xRaw,solutesRaw(:,i),iterRandom,selectedModel,optimMethod);
           paramMatrix(:,i)=bestParam(:)';%Matrix containing different parameters of the optimized values.
           [data,l]=prepareComparation(n,f,x,y,D)
           optimData(:,:,i)=data;
           pos(i)=l;
           X(:,i)=[x(:)' zeros(1,l)];
           Y(:,i,1)=[y(:)' zeros(1,l)];
         endfor
         B.autoOptimization=paramMatrix;
         comparation(n,optimData,pos);
         plotErrorMatrix(optimData,pos);
         [Xnew,Ynew,keepX]=plotOptimization(X,Y,f,paramMatrix,pos);
         out=isempty(find(keepX==0));
         counterRem=1;%Counter for removed data cycles
         while(out==0) %User has selected points to remove and perform optimization
            Xnew(Xnew==0)=NaN; %Now we perform the loop again
            Ynew(Ynew==0)=NaN;
            removeData=true;
            Xnew
            Ynew
            [m,n]=size(Xnew)
            clear X,Y,paramMatrix;
            for i=1:n
                [bestParam,x,y,f,D]=univariantRetOptim(Xnew(:,i),Ynew(:,i),iterRandom,selectedModel,optimMethod);
                B.autoRemovedOptimization(:,i,counterRem)=bestParam';
                [data2,l2]=prepareComparation(m,f,x,y,D);
                X(:,i)=[x(:)' zeros(1,l2)];
                Y(:,i,1)=[y(:)' zeros(1,l2)];
                optimData2(:,:,i)=data2;
                pos2(i)=l2;
            endfor
            n
            optimData2
            pos2
         comparation(m,optimData2,pos2);
         plotErrorMatrix(optimData2,pos2);
         [Xnew,Ynew,keepX]=plotOptimization(X,Y,f,B.autoRemovedOptimization(:,:,counterRem),pos2);
         counterRem=counterRem+1;
         endwhile
         %Here data should be saved in case removing points is not helpful for optimization improvement
    elseif(modelType==2)
      for i=1:size(solutesRaw)(2)
         [xRaw,X,Y,iterRandom] = defOptimConstBi(A); %Defining constants for optimization calculation and plotting...
         [bestParam x z f D]=bivariantRetOptim(xRaw,solutesRaw(:,i),X,Y,iterRandom,selectedModel,optimMethod);
         paramMatrix(:,i)=bestParam';
         [data,l]=prepareComparation(n,f,x,z,D);
         optimData(:,:,i)=data;
         pos(i)=l;
      endfor
      comparation(n,optimData,pos);
      plotErrorMatrix(optimData,pos);
      [Xnew,keepX]=plotOptimization
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
