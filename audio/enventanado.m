function segmentos_enventanados = enventanado(segmentos,ventana)
    switch ventana
        case 'rectangular'
            vent = rectwin(size(segmentos,1));
            vent = repmat(vent,1,size(segmentos,2));
            segmentos_enventanados = segmentos.*vent;
        case 'hamming'
            vent = hamming(size(segmentos,1));
            vent = repmat(vent,1,size(segmentos,2));
            segmentos_enventanados = segmentos.*vent;
        case 'hanning'
            vent = hanning(size(segmentos,1));
            vent = repmat(vent,1,size(segmentos,2));
            segmentos_enventanados = segmentos.*vent;
        otherwise
            disp('Ventana erronea');
    end
end