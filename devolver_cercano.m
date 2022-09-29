%Esta función busca en el vector w los elementos más cercanos a los de I y devuelve su posición.
function  position=returnClosest(w,I)  %w vector vertical. I vector de elementos.
          n=length(w);
          m=length(I);
          position=zeros(1,m);
            for i=1:m
                dist= abs(w-I(i));
                minim=min(dist);
                p=find(dist==minim);
                if length(p)>1
                   p=p(2); %Solución temporal: más cercano a t_R para que calcule bien la distancia.
                endif
                position(i)=p;
            end
 end
