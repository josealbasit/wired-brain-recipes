initParam =[  -9.1599e+01
   1.3137e+03
   2.1105e-01];
f_min=@(x,p) p(1).*exp(-p(2).*(x./(1+p(3).*x)));
x =[ 0.1000
   0.1300
   0.1500
   0.1700
   0.2000
   0.3000];

   y =[  0.9282
   0.5826
   0.5065
   0.4615
   0.3919
   0.4515];

try
  options=generateBounds(initParam);
  wt = ones(size(y));
  dp = [0.001; 0.001; 0.001]; % bidirectional numeric gradient stepsize
  f_min(x,initParam)
  [y_optim, optimParam, kvg1, iter1, corp1, covp1, covr1, stdresid1, Z1, r2] = leasqr(x, y, initParam, f_min,0.00000001, 200, wt, 0.001 * ones (size (initParam)), "dfdp", options); %Applying leasqr () to desired function...
catch
  tform2 = 0;
end

