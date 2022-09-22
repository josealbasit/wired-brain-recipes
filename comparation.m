function comparation(x,optimData,pos)
  optimData
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
  soluteLabel=mean([min(optimData(:,1,j)) max(optimData(:,1,j))]);
  for i=1:size(optimData)(2)
   plot(optimData(1:l,1,j),optimData(1:l,i,j),'o')
   hold on
   label=["Solute " num2str(j)];
   text(soluteLabel,5*soluteLabel/(2*j),label)
  endfor
  endfor
  xlabel("k")
  ylabel("predicted k")
  legend("Retention data")
  title("Retention Prediction")
  waitforbuttonpress();
endfunction

