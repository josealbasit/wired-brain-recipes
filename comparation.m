function comparation(n,optimData,pos)
  default_octave();
  colors=['g' 'b' 'c' 'm' 'r'];
  all_labels="";
  colors=[colors colors colors colors];
  close all;
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
  l=n-pos(j);
  z_predicted=optimData(1:l,:,j);
  [dim1 dim2]=find(abs(z_predicted)>1000); %bounding values [-1000,1000]
  if(length(dim1)>1)
  infCols=unique(dim2);% Colums bigger that contain a prediction bigger than 1000
  z_predicted(:,infCols)=[];
  endif
  if(size(z_predicted)(2)==0)
  msgbox(["Optimization for solute " num2str(j) " has been unsuccessful. Values exceed boundaries." ]);
  else
  minim=min(min(z_predicted));
  maxim=max(max(z_predicted));
  soluteLabel=mean([minim maxim]);
  hold on
  label=["Solute " num2str(j)];
  xplot=repmat(optimData(1:l,1,j),1,size(z_predicted)(2))(:)
  plot(xplot,z_predicted(:),[[colors(j)] 'o'],'DisplayName',label)
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

