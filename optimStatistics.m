function [r2 errorOptim]=optimStatistics(y,y_optim,p)
  y=y(:);
  y_optim
  p
  n=length(y);
  r2=[cov(y,y_optim)/(std(y)*std(y_optim))].^2;
  error_mean=sum(abs(y_optim-mean(y)))/sum(abs(y_optim))
  errorOptim=sum(abs(y-y_optim))/mean(y);
  std_prediction=sumsq(y-y_optim)/(n-p);

end

