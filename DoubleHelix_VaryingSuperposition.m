% Ralf Mouthaan
% University of Adelaide
% December 2023
%
% Script to generate double helix point spread functions as per:
% Pavani & Piestun, "High-Efficiency Rotating Point Spread Functions",
% Optics Express, Vol. 16, No. 5, 2008
%
% The double helix beams are made up of a superposition. Here, I play
% around with that superposition to see how it evolves with z. I don't
% generate the corresponding holograms.

clc; clear variables; close all;
clear LaguerreGaussBeam;

addpath('Functions\')

%% User-defined variables

bolDebug = false;
lambda = 532e-9; % Green light
Nx = 1000;
xnorm = linspace(-10,10,Nx); % normalised x used for generating LG beams
                             % Needs to be this range to ensure
                             % orthogonality of LG beams
arrz = linspace(-25e-6, 25e-6, 50); 

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

%% LG superposition and LG weights

fprintf('Calculating initial LG superposition...\n')

for n = 0:4

    p = n*2 + 1;
    l = n*2 + 1;

    % Initial field
    F = F + LaguerreGaussBeam(p, l, xnorm);

    fprintf('LG_{%d,%d}\n', p, l)
    plMat(p, l) = 1;
                
end

figure;
imagesc(plMat);
xlabel('l');
ylabel('p');
drawnow;

%% Vary z

% Save gif of rotating points
figure;
for idxz = 1:length(arrz)
    Fz = PropagateZ(F, arrz(idxz), lambda, kr);
    imagesc(abs(Fz).^2);
    axis square;
    xticks('');
    yticks('');
    title(['z = ' num2str(arrz(idxz)*1e6) 'um']);
    drawnow;
    if idxz == 1
        exportgraphics(gcf,'Results/Rotating Double Helix.gif','Append',false);   
    else
        exportgraphics(gcf,'Results/Rotating Double Helix.gif','Append',true);
    end
end


