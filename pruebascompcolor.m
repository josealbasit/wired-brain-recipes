x=linspace(1,10,100)
y=rand(1,100)*10;
colors=[0 0.4470 0.7410
  0.8500 0.3250 0.0980
  0.9290 0.6940 0.1250
  0.4940 0.1840 0.5560
  0.4660 0.6740 0.1880
  0.3010 0.7450 0.9330
  0.6350 0.0780 0.1840
  0 1 1
  1 0 0
  1 1 0
  0 0 1
  0 1 0
  0 1 1
  0 0 0];
newcolors = {'#FF00','#F80','#FF0','#0B0','#00F','#50F','#A0F'};
%newcolors={'#FF00','#','#','#','#','#','#','#','#','#','#','#','#','#'}
for i=1:20
clf
scatter(x,y,25,colors(i,:),'filled','DisplayName',"hola")
waitforbuttonpress
c(1)=c(1)+0.05
end
legend show

%scatter(x,y,[],c,'filled')
