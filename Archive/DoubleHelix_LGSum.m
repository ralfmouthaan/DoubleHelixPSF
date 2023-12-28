% Ralf Mouthaan
% University of Adelaide
% December 2023
%
% Script to generate double helix point spread functions as per:
% Pavani & Piestun, "High-Efficiency Rotating Point Spread Functions",
% Optics Express, Vol. 16, No. 5, 2008

clc; clear variables; %close all;

Nx = 1000;
x = linspace(-10,10,Nx);
F = zeros(Nx, Nx);

for n = 0:4
    F = F + LaguerreGaussBeam(n*4 + 1, n*2 + 1, x);
end

figure; 
imagesc(abs(F).^2);
axis square;

