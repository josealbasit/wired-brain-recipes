function comparation(x,z,f,optimData,pos)
  close all;
  z_col=reshape(optimData(:,1,:))';
  m=(size(D)(2)-2)/2;
  plot(z_col,z_col,'r');
  hold on
  plot(z_col,z_col,'+')
  hold on
  for j=1:size(optimData)(3)
  l=length(x)-pos(j);
  for i=1:size(optimData)(2)
   plot(optimData(1:l,1,j),optimData(1:l,i,j),'o')
   hold on
  endfor
  endfor
  xlabel("k")
  ylabel("predicted k")
  legend("Retention data")
  title("Retention Prediction")
  waitforbuttonpress();
endfunction

