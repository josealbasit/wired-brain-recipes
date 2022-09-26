function comparation(x,optimData,pos)
  dim=zeros(1,2);
  close all;
  z_col=optimData(:,1,:)(:);
  plot(z_col,z_col,'r');
  hold on
  plot(z_col,z_col,'+')
  hold on
  if(length(size(optimData))==3)
  m=size(optimData)(3);
  else
  m=1;
  end
  for j=1:m
  l=length(x)-pos(j);
  z_predicted=optimData(:,1,j);
  dim=find(z_predicted>1000);
  z_predicted(dim(2))% Colums bigger thath contain a prediction bigger than 1000


  z_predicted=z_predicted(z_predicted<1000); %bounding values
  z_predicted=z_predicted(z_predicted>-1000);
  z_predicted=
  soluteLabel=mean([min(z_predicted) max(z_predicted]);
  for i=1:size(optimData)(2)
   plot(optimData(1:l,1,j),optimData(1:l,i,j),'o')
   hold on
   endfor
   label=["Solute " num2str(j)];
   text(soluteLabel,5*soluteLabel/(2*j),label)
  endfor
  xlabel("k")
  ylabel("predicted k")
  legend("Retention data")
  title("Retention Prediction")
  waitforbuttonpress();
endfunction

