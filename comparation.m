function comparation(n,optimData,pos,numberSol)
  default_octave();
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
  all_labels="";
  colors=[colors; colors; colors; colors];
  close all;
  h=figure(1,"position",get(0,"screensize")([3,4,3,4]).*[0.1 0.2 0.4 0.4])
  z_col=optimData(:,1,:)(:);
  plot(z_col,z_col,'r','DisplayName','Retention Data');
  hold on
  plot(z_col,z_col,'k+','DisplayName','Experimental value')
  hold on
  if(length(size(optimData))==3)
  m=size(optimData)(3);
  else
  m=1;
  end
  for j=1:m
  l=n-pos(j)
  z_predicted=optimData(1:l,:,j);
  [dim1 dim2]=find(abs(z_predicted)>1000); %bounding values [-1000,1000]
  if(length(dim1)>1)
  infCols=unique(dim2);% Colums bigger that contain a prediction bigger than 1000
  z_predicted(:,infCols)=[];
  endif
  if(size(z_predicted)(2)==0)
  msgbox(["Optimization for solute " num2str(numberSol(j)) " has been unsuccessful. Values exceed boundaries." ]);
  else
  minim=min(min(z_predicted));
  maxim=max(max(z_predicted));
  soluteLabel=mean([minim maxim]);
  hold on
  label=["Solute " num2str(numberSol(j))];
  xplot=repmat(optimData(1:l,1,j),1,size(z_predicted)(2))(:);
  scatter(xplot,z_predicted(:),25,colors(j,:),'filled','DisplayName',label)
  text(soluteLabel,1.75*soluteLabel,label,'fontsize',12,'fontweight','bold')
  all_labels=[all_labels label];
   endif
  endfor
  xlabel("k")
  ylabel("Predicted k")
  legend show;
  title("Retention Prediction")
  hold off
endfunction

