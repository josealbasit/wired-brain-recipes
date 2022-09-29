function updatePlot(A,X,Y,j,)
  index=A(:,3); %Subplot Index
  n=length(index);
  for i=1:n
    x=X(:,index(i));
    y=Y(:,index(i));
    position=returnClosest(x,A(i,1));
    x(position)=[];
    y(position)=[];
    Xnew=[Xnew x(:)];
    Ynew=[]
    subplot(2,2,i,'replace')
    plot(
    
  endfor
  subplot(2,2,1,'replace')
  plot(x,infCols)
  infCols=unique(dim2);% Colums bigger that contain a prediction bigger than 1000
  z_predicted(:,infCols)=[];
end
