function [CEN]=getFinger(imgA,imgB,handles)
img = imgA - imgB; % Quitamos el fondo
img = imcomplement(img);
img = flipdim(img,2);

img2 = imclose(img, strel('disk',5));
img3 = skinDetection(img2); % Umbraliza con el color de piel

img3 = imclose(img3, strel('disk',8)); 

REG=regionprops(img3,'all');
REG=regionprops(img3,'Centroid','BoundingBox','Area');
REG(vertcat(REG.Area) ~= max(vertcat(REG.Area))) = [];
CEN = cat(1, REG.Centroid);
BB = cat(1, REG.BoundingBox);
c = 1;
if ~isempty(BB) && BB(4)/BB(3) > c
	axes(handles.demoFinger);
    if any(~isempty(CEN) && ~isempty(BB))
        imshow(flipdim(imgB,2),[]), hold on,
        rectangle('Position', BB,...
        'EdgeColor','b', 'LineWidth', 3),
        plot(CEN(1),CEN(2),'r*'),
        hold off; 
    end
else
    CEN=[];
end

end