function res = desplazamiento(x1,x2,tam)
    umbral1 = 100;
    if abs(x1-x2) < umbral1
        if x2 < tam/2
            res = -1;
        elseif x2 > tam/2
            res = 1;
        else
            res = 0;
        end
    else
        if x1 < x2
            res = 1;
        else
            res = -1;
        end
    end
    
end