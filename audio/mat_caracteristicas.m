%%PRACTICA 4
function [senal,palabra,segmentos_enventanados,caracteristicas] = mat_caracteristicas(tiempo,Fs,Ch,num_bits,coef_pre,long_trama,despl,seg_ruido,p)
%%Preprocesado
senal = grabacion(tiempo,Fs,Ch,num_bits);
senal = senal(700:end);
senal = preenfasis(senal,coef_pre);

segmentos = segmentacion(senal,long_trama,despl);
palabra = inicio_fin(segmentos,seg_ruido);

segmentos_enventanados = enventanado(palabra,'hamming');

%%Extraccion de caracteristicas
if isreal(segmentos_enventanados) && ~isempty(segmentos_enventanados)
    cepstrum = rceps(segmentos_enventanados);
    coeficientes = cepstrum(2:13,:);

    matriz_coefs = [zeros(size(coeficientes,1),p) coeficientes zeros(size(coeficientes,1),p)];
    vector_den = [zeros(1,p) ones(1,size(coeficientes,2)) zeros(1,p)];
    mascara_den = (-p:p);
    mascara_num = repmat(mascara_den,size(coeficientes,1),1);

    for i=1:size(coeficientes,2)
        delta_num = sum(mascara_num.*matriz_coefs(:,i:i+length(mascara_den)-1),2);
        delta_den = sum((mascara_den.^2).*vector_den(i:i+length(mascara_den)-1));
        delta(:,i) = delta_num./delta_den;
    end

    %%Postprocesamiento
    caracteristicas = [coeficientes;delta];

    std = stdpat(caracteristicas);
    std = repmat(std,1,size(caracteristicas,2));

    caracteristicas = zeromean(caracteristicas);
    caracteristicas = caracteristicas./std;
else
    caracteristicas = [];
end
end