%Esta función busca en el vector w los elementos más cercanos a los de I y devuelve su posición.
function  position=returnClosest(w,I)  %w vector vertical. I vector de elementos.
          n=length(w);
          m=length(I);
          dist= abs(w-I);
          minim=min(dist);
          position=find(dist==minim);
 end
