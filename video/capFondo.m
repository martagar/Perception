function fondo = capFondo(camN)
    global cam;
    if isempty(cam)
        cam = webcam(camN);
        pause(2);
    end
    fondo = snapshot(cam);
end