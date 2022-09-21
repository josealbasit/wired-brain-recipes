function [data,l]=prepareComparation (x,f,z,D)
  n=length(x);
  m=(size(D)(2)-2)/2;
  param=D(:,m+1:2*m);
  z_predicted=zeros(0,0);
  for(i=1:rows(D))
  z_predicted=[z_predicted f(param(i,:))(:)];
  endfor
  data=[z(:) z_predicted]
  z_predicted
  if(length(z)<n)
     l=n-length(z)
     data=[data;zeros(l,size(data)(2))];
  end


end
