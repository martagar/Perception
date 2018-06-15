function salida = cruces_por_cero(segmentos,ventana)
    N = size(segmentos,2);
    
    trozo1 = sign(segmentos(1:end-1,:));
    trozo2 = sign(segmentos(2:end,:));
    segmentos = abs(trozo1-trozo2)./2;
    
    ventana = repmat(ventana,1,size(segmentos,2));
    salida = (segmentos'*ventana)./N;
    salida = salida(:,1);
end