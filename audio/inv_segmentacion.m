function palabra = inv_segmentacion(segmentos, despl)
    new = segmentos(size(segmentos,1)-despl:end,2:end);
    ind = find(new ~= 0);
    new = new(ind);
    primera = segmentos(:,1);
    primera = primera(:);
    new = new(:);
    palabra = [primera; new];
end