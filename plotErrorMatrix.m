function plotErrorMatrix(optimData,pos)
  colors=['g' 'b' 'c' 'm'];
  colors=[colors colors colors colors];
  if(length(size(optimData))==2)
  l=1;
  optimData(:,:,1)=optimData(:,:);
  else
  l=size(optimData)(3);
  z_col=optimData(:,1,:)(:);
  z0=zeros(1,length(z_col));
  figure
  plot(z_col,z0,'r')
  hold on
  plot(z_col,z0,'+')
  hold on
  for j=1:l
    errorMatrix(:,:)=[optimData(1:end-pos(j),1,j)-optimData(1:end-pos(j),2:end,j)]./mean(optimData(1:end-pos(j),1,j)(:));
    minim=min(min(errorMatrix(:,:)));
    maxim=max(max(errorMatrix(:,:)));
    dim=find(abs(errorMatrix)>1000); %bounding values [-1000,1000]
    if(length(dim)>1)
    infCols=unique(errorMatrix(dim(2)));% Colums bigger that contain a prediction bigger than 1000
    errorMatrix(:,infCols)=[];
    endif 
    for i=1:size(errorMatrix)(2)
      plot(optimData(1:end-pos(j),1,j),errorMatrix(:,i),[colors(j) 'o']);
      hold on
    endfor
    soluteLabel=mean([min(min(optimData(:,:,j))) max((optimData(:,:,j)))])
    maxim
    label=["Solute " num2str(j)];
    text(soluteLabel,0.95*maxim,label,'fontsize',12,'fontweight','bold');
    hold on
 endfor
  xlabel("Retention")
  ylabel("Error in prediction")
  legend("Retention prediction error data")
  title("Retention Prediction")
  waitforbuttonpress();
end
