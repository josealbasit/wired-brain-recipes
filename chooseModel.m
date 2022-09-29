function selectedModel=chooseModel(modelType)
   if (modelType==1)
    %open("UnivariantRetModels.png");
    selectedModel=menu("HPLC retention models:","1. LSS","2. QSS","3. Neue / Polarity","4. Neue-Kuss","5. Jandera 2p","6. Jandera 3p","7. Elution g","8. Micelar ")
   elseif (modelType==2)
    %open(image="BivariantRetModels.png");
    selectedModel=menu("Additive present retention models:","1. MH 4p","2. MH 5p sqr","3. MH 4p (b)","4. MH 5p","5","6");
   endif
   close all;
  end

