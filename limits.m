function lim=limits(estimParam)

  epsilon=abs(estimParam*1e5);
  lim=[(estimParam-epsilon)(:) (estimParam+epsilon)(:)]


  end
