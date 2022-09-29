function modelType=checkRetData(A)
  dim=size(A);
  modelType=menu("Your data corresponds to L.C. with:","One solvent or additive!","Two or more addit/solvents")

  if(modelType==0)
  msgbox("Please enter again retention data, columns of the independent variables must be 2 or 3");
  endif

  end
