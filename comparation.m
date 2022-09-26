function comparation(x,optimData,pos)
  optimData
  dim=zeros(1,2);
  colors=['g' 'b'  'c' 'm'];
  colors=[colors colors colors colors];
  close all;
  z_col=optimData(:,1,:)(:);
  plot(z_col,z_col,'r');
  hold on
  plot(z_col,z_col,'k+')
  hold on
  if(length(size(optimData))==3)
  m=size(optimData)(3);
  else
  m=1;
  end
  for j=1:m
  l=length(x)-pos(j);
  z_predicted=optimData(:,1,j);
  dim=find(abs(z_predicted)>1000); %bounding values [-1000,1000]
  if(length(dim)>1)
  infCols=unique(z_predicted(dim(2)));% Colums bigger that contain a prediction bigger than 1000
  z_predicted(:,infCols)=[];
  endif
  minim=min(z_predicted);
  maxim=max(z_predicted);
  soluteLabel=mean([minim maxim]);
  for i=1:size(optimData)(2)
   plot(optimData(1:l,1,j),optimData(1:l,i,j),[[colors(j)] 'o'])
   hold on
   endfor
   %plot([minim,minim],[-3*maxim, 3*maxim]);
   %hold on
   %plot([maxim,maxim],[-3*maxim, 3*maxim]);
   label=["Solute " num2str(j)];
   text(soluteLabel,1.5*soluteLabel,label,'fontsize',12,'fontweight','bold')
   hold on
  endfor
  xlabel("k")
  ylabel("predicted k")
  legend("Retention data")
  title("Retention Prediction")
  waitforbuttonpress();
endfunction

