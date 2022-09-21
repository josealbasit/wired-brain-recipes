function R=f_bounded_powell_nm_bivariant(p,x1,x2,z,lim,selectedModel)
  r=rand();
  if(r> .97)
  r
  lim
  p
  a=p(:)<lim(:,1)
  b=p(:)>lim(:,2)
  end
  if(sum(p'<lim(:,1))>.5|sum(p'>lim(:,2))>.5)
    1
    lim
    p
    R=1e32;
  else
    switch(selectedModel)
    case 1
    R=sumsq(z-p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2));
    case 2
    R=sumsq(z-p(1)./(1+p(2).*x1+p(3).*x2+p(4).*x1.*x2+p(5).*x1.*(sqrt(x2))));
    case 3
    R=sumsq(z-[p(1)./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1]);
    case 4
    R=sumsq(z-[[p(1).*(1+p(5).*x2)]./(1+p(2).*x2)]./[1+p(3).*[(1+p(4).*x2)./(1+p(2).*x2)].*x1]);
    case 5
    R=sumsq(z-[p(1).*(1+p(6).*x2)]...
      ./[1+p(4).*x1+p(2).*x2+p(3).*x2.^2+p(4).*p(5).*x1.*x2])
    case 6
    R=sumsq(z-[p(1)]./[1+p(6).*[(1+p(4).*x2+p(5).*x2.^2)./(1+p(2).*x2+p(3).*x2.^2)].*x1]);
  end
end










