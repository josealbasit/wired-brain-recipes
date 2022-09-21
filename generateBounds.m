function options=generateBounds(initParam)

epsilon=abs(3*initParam);
A=[(initParam-epsilon)(:) (initParam+epsilon)(:)];
options.bounds=A;

end
