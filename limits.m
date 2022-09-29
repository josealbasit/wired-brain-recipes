function lim=limits(estimParam)
  %if(selectedModel==4)
  %limits(:,1)=[-1,15];
  %limits(:,2)=[0,100];
  %limits(:,3)=[0,300];

  epsilon=abs(estimParam*1e5);
  lim=[(estimParam-epsilon)(:) (estimParam+epsilon)(:)]


  end
