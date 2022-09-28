%Esta función busca en el vector w los elementos más cercanos a los de I y devuelve su posición.
function  posicion=devolver_cercano(w,I)  %w vector vertical. I vector de elementos.
          n=length(w);
          m=length(I);
          posicion=zeros(1,m);
            for i=1:m
                distancias= abs(w-I(i));
                minimo=min(distancias);
                p=find(distancias==minimo);
                if length(p)>1
                   p=p(2); %Solución temporal: más cercano a t_R para que calcule bien la distancia.
                endif
                posicion(i)=p;
            end
 end
