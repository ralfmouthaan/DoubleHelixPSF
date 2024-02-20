% Ralf Mouthaan
% University of Adelaide
% January 2024
%
% Investigation into why gratings are working but twin airy hologram is
% not.

clc; clear variables; close all;

% Twin Airy images:
ImgFiles = {'PSFOff.tif', 'PSFR005.tif', 'PSFR005.tif', 'PSFR010.tif', 'PSFR025.tif', 'PSFR050.tif', 'PSFR100.tif'};

% Blazed Grating images:
%ImgFiles = {'PSFOff.tif', 'PSFBlazedGrating5.tif', 'PSFBlazedGrating15.tif', 'PSFBlazedGrating5Hor.tif'};

figure;
for i = 1:length(ImgFiles)
   
    Img = imread(ImgFiles{i});

    subplot(ceil(sqrt(length(ImgFiles))), ceil(sqrt(length(ImgFiles))), i);
    imagesc(Img);
    title(ImgFiles{i})
    axis image;
    colorbar;

end