function elemento = recVoz(handles,elementos,nivel)
    global errorRuido;
    load('utiles_audio.mat');
    load('entrenamiento_def.mat');

    Fs = 8000;
    coef_pre = 0.95;
    long_trama = 100;
    despl = 75;
    seg_ruido = 10;
    tiempo = 1;
    Ch = 1;
    num_bits = 16;
    p = 10;
   
    h_on = imshow(rec_on, 'Parent', handles.iconRecA);
    set(h_on,'AlphaData',alpha_rec);
    pause(0.5)
    [~,t_palabra,~,t_caracteristica] = mat_caracteristicas(tiempo,Fs,Ch,num_bits,coef_pre,long_trama,despl,seg_ruido,p);

    h_off = imshow(rec_off, 'Parent', handles.iconRecA);
    set(h_off,'AlphaData',alpha_rec);
    
    if ~isempty(t_caracteristica)
        for j = 1:(nivel*8)
            error(j) = alg_DTW_local(entrenamiento{j},t_caracteristica);
        end
        
        for j = 1:8
            errorC(j) = alg_DTW_local(entrenamiento{j+48},t_caracteristica);
        end
        
        [error_min,elemento] = min(error);
        error_minC = min(errorC);
        
        if isempty(errorRuido)
            errorRuido = 360;
        end
        if error_min > errorRuido
            elemento = 0;
        end
        
        if error_minC < error_min
            if error_minC > errorRuido
                elemento = 0;
            else
                elemento = 7;
            end
        else
            elemento = ceil(elemento/8);
        end
    else
        elemento = 0;
    end
    if elemento == 0 
        set(handles.textFood, 'String', '<no element>');
    elseif elemento <= length(elementos)
        set(handles.textFood, 'String', elementos(elemento));
    end
end