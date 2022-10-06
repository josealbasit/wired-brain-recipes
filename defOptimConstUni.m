function [x,iterRandom,errorMatrix] = defOptimConstUni(A) %Defines optimization consta
   x=A(:,1);
   iterRandom=1;
   errorMatrix=zeros(3*10+3,rows(A));%Error matrix to perform outlier detection later on
  end
