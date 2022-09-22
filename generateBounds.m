function options=generateBounds(initParam)

epsilon=abs(20*initParam);
A=[(initParam-epsilon)(:) (initParam+epsilon)(:)];
options.bounds=A;

end
