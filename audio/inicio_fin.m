function segmentos = inicio_fin (segmentos, num_segmentos_ruido)
    % Paso 1
    vent_cruces = rectwin(size(segmentos,1)-1);
    cruces = cruces_por_cero(segmentos, vent_cruces);
    
    vent_magnitud = rectwin(size(segmentos,1));
    mag = magnitud(segmentos, vent_magnitud);
    
    % Paso 2
    Mag_Ruido = mag(1:num_segmentos_ruido);
    Cru_Ruido = cruces(1:num_segmentos_ruido);
    
    % Paso 3    
    meanMagRuido = mean(Mag_Ruido);
    stdMagRuido = std(Mag_Ruido);
    meanCruRuido = mean(Cru_Ruido);
    stdCruRuido = std(Cru_Ruido);
    
    UmbSupEnrg = 0.5*max(mag);
    UmbinfEnrg = meanMagRuido + 2*stdMagRuido;
    UmbCruCero = meanCruRuido + 2*stdCruRuido;
    
    for i = 1:2
        % Paso 4
        ln = find(mag(num_segmentos_ruido+1:end) > UmbSupEnrg);
        if isempty(ln)
            ln = num_segmentos_ruido;
        else
            ln = ln(1) + num_segmentos_ruido;
        end

        % Paso 5
        le = find(mag(1:ln) < UmbinfEnrg);
        if isempty(le)
            le = num_segmentos_ruido;
        else
            le = le(end);
        end
            
        % Paso 6
        busqueda = cruces(le:le-25);
        if all(busqueda < UmbCruCero)
            limites(i) = le;
        else
            ind = find(diff(busqueda)==1);
            ind2 = find(diff(ind)==1);
            if ~isempty(ind2)     
                ind2 = ind2(1);
                ind = ind(ind2);
                limites(i) = le - ind + 1;
            else
                limites(i) = le;
            end
        end
        mag = flipud(mag);
        cruces = flipud(cruces);
    end            
    segmentos = segmentos(:,limites(1):size(segmentos,2)-limites(2));
end