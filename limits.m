function lim=limits(estimParam)

  epsilon=abs(estimParam*1e10);
  lim=[(estimParam-epsilon)(:) (estimParam+epsilon)(:)]


  end
