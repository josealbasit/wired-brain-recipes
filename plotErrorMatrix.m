function plotErrorMatrix(optimData,pos)
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
    errorMatrix(:,:)=[optimData(1:end-pos(j),1,j)-optimData(1:end-pos(j),2:end,j)]./optimData(1:end-pos(j),1,j)(:)
    soluteLabel=mean([min(optimData(:,1,j)) max(optimData(:,1,j))]);
    label=["Solute " num2str(j)];
    a=max(max(errorMatrix));
    text(soluteLabel,1.5*a,label);
    for i=1:size(errorMatrix)(2)
      plot(optimData(1:end-pos(j),1,j),errorMatrix(:,i),'o');
      hold on
    endfor
 endfor
  xlabel("Retention")
  ylabel("Error in prediction")
  legend("Retention prediction error data")
  title("Retention Prediction")
  waitforbuttonpress();
end
