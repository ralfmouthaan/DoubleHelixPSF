% Ralf Mouthaan
% University of Adelaide
% February 2024
%
% Plot hologram and corresponding replay field

clc; clear variables; close all;

%% User picks file

HoloFiles = {'BlazedGrating_Period5.bmp', 'BlazedGrating_Period5Hor.bmp', 'BlazedGrating_Period15.bmp', 'TwinAiryMask.bmp'};
idx = 4;

%% Calculations

Holo = imread(HoloFiles{idx});
if size(Holo, 3) > 1
    Holo = rgb2gray(Holo);
end
Holo = double(Holo);

x = (1:size(Holo, 2)) - size(Holo, 2)/2;
y = (1:size(Holo, 1)) - size(Holo, 1)/2;
[x, y] = meshgrid(x, y.');
Illum = exp(-(x.^2 + y.^2)/100000);

figure;
imagesc(Illum);
axis image;
title("Illumination")

Holo = Illum.*exp(1i*Holo);
Replay = fftshift(fft2(fftshift(Holo)));

%% Plotting

figure;
subplot(1,2,1);
imagesc(angle(Holo));
axis image;
title(HoloFiles{idx});
colormap gray;

subplot(1,2,2);
imagesc(abs(Replay).^2);
axis image;
title('Replay');
colormap gray;