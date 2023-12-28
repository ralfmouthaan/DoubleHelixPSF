% Ralf Mouthaan
% University of Adelaide
% December 2023
%
% Script to generate double helix point spread functions as per:
% Pavani & Piestun, "High-Efficiency Rotating Point Spread Functions",
% Optics Express, Vol. 16, No. 5, 2008

clc; clear variables; close all;
clear LaguerreGaussBeam

%% User-defined variables

lambda = 532e-9; % Green light
Nx = 1000;
xnorm = linspace(-10,10,Nx); % normalised x used for generating LG beams

%% Coordinate systems

% Real space
kz = 2*pi/lambda;
x = linspace(-15e-6, 15e-6, Nx);
r = sqrt(x.^2 + x.'.^2);
dx = x(2) - x(1);

% Inverse space
kx = linspace(-1/dx/2, 1/dx/2, Nx); % Do I need a factor of 2pi in here?
kr = sqrt(kx.^2 + kx.'.^2);

% Initialise fields
F = zeros(Nx, Nx);

%% Calculate initial field from LG superposition

for n = 0:4
    F = F + LaguerreGaussBeam(n*4 + 1, n*2 + 1, xnorm);
end


%% Check decomposition

arrp = 0:20; arrl = -10:10;

for idxp = 1:length(arrp)
    p = arrp(idxp);
    for idxl = 1:length(arrl)
        l = arrl(idxl);

        fprintf('LG %d %d\n', p, l)

        LG = LaguerreGaussBeam(p, l, xnorm);

        C(idxp,idxl) = abs(sum(sum(F.*conj(LG)))).^2;
        C(idxp,idxl) = C(idxp,idxl) / sum(sum(abs(F).^2));
        C(idxp,idxl) = C(idxp,idxl)  / sum(sum(abs(LG).^2));

    end
end

figure;
imagesc(arrl, arrp, C);
axis image;
set(gca, 'ydir', 'normal') % To agree with Pavani paper