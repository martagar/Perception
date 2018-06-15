function salida = energia(segmentos,ventana)
    ventana = repmat(ventana,1,size(segmentos,2));
    salida = (segmentos'.^2)*(ventana.^2);
    salida = salida(:,1);
end