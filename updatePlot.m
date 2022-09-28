function updatePlot(A,X)

  index=A(:,3); %Subplot Index
  n=length(index);
  for i=1:n
    w=X(:,index(i));
    position=returnClosest(w,A(i,1));
  endfor
  subplot(2,2,1,'replace')
  plot(x,)

end
