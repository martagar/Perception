function mov = recVideo(camN,imgA,handles)
global cam;
load('utiles_video.mat');

if isempty(cam)
    cam = webcam(camN);
    pause(2);
end

N = 5;
celdaImg = cell(1,N);
cen1 = size(imgA,2)/2;

h_on = imshow(rec_on, 'Parent', handles.iconRecV);
set(h_on,'AlphaData',alpha_rec);
pause(1);

movi = zeros(1,N);
i = 1;
while i<=N
    if isempty(cam)
        break;
    end
    celdaImg{i} = snapshot(cam);
    cen2 = getFinger(imgA,celdaImg{i},handles);
    
    if ~isempty(cen2)
        movi(i) = desplazamiento(cen1(1),cen2(1),size(imgA,2));
        cen1 = cen2;
    else
        movi(i) = 0;
    end    
    i = i+1;
end
h_off = imshow(rec_off, 'Parent', handles.iconRecV);
set(h_off,'AlphaData',alpha_rec);
if ~all(movi == 0)
    mov = mode(movi(movi ~= 0));
else
    imshow(zeros(size(imgA)), 'Parent', handles.demoFinger);
    mov = 0;
end
end