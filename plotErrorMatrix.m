function plotErrorMatrix(optimData,pos)
    colors=[0 0.4470 0.7410
  0.8500 0.3250 0.0980
  0.9290 0.6940 0.1250
  0.4940 0.1840 0.5560
  0.4660 0.6740 0.1880
  0.3010 0.7450 0.9330
  0.6350 0.0780 0.1840
  0 1 1
  1 0 0
  1 1 0
  0 0 1
  0 1 0
  0 1 1
  0 0 0];
  colors=[colors;colors; colors; colors];
  if(length(size(optimData))==2)
  l=1;
  optimData(:,:,1)=optimData(:,:);
  else
  l=size(optimData)(3);
  endif
  z_col=optimData(:,1,:)(:);
  z0=zeros(1,length(z_col));
  figure
  plot(z_col,z0,'r','DisplayName','Retention Data')
  hold on
  plot(z_col,z0,'+','DisplayName','Experimental Values')
  hold on
  for j=1:l
    errorMatrix=[optimData(1:end-pos(j),1,j)-optimData(1:end-pos(j),2:end,j)]./mean(optimData(1:end-pos(j),1,j)(:));
    [dim1 dim2]=find(abs(errorMatrix)>1000); %bounding values [-1000,1000]
    if(length(dim1)>1)
    infCols=unique(dim2);% Colums bigger that contain a prediction bigger than 1000
    errorMatrix(:,infCols)=[];
    endif
    minim=min(min(errorMatrix));
    maxim=max(max(errorMatrix));
    label=["Solute " num2str(j)];
    xplot=repmat(optimData(1:end-pos(j),1,j),1,size(errorMatrix)(2))(:);
    scatter(xplot,errorMatrix(:),25,colors(j,:),'filled','DisplayName',label);
 endfor
  xlabel("Retention")
  ylabel("Error in prediction")
  legend show;
  title("Retention Prediction")
  hold off
  waitforbuttonpress();
end
