function salida = magnitud(segmentos,ventana)
    ventana = repmat(ventana,1,size(segmentos,2));
    salida = abs(segmentos')*ventana;
    salida = salida(:,1);
end