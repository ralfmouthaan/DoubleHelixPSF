% Ralf Mouthaan
% University of Adelaide
% December 2023
%
% Script to generate double helix point spread functions as per:
% Pavani & Piestun, "High-Efficiency Rotating Point Spread Functions",
% Optics Express, Vol. 16, No. 5, 2008

clc; clear variables; close all;
clear LaguerreGaussBeam;

%% User-defined variables

lambda = 532e-9; % Green light
Nx = 1000;
xnorm = linspace(-10,10,Nx); % normalised x used for generating LG beams
                             % Needs to be this range to ensure
                             % orthogonality of LG beams

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

%% Check spots rotate as they propagate

arrz = linspace(-3e-6, 3e-6, 11);
invF = ifftshift(fft2(fftshift(F)));

for idxz = 1:length(arrz)
    
    % Angular spectrum method for propagation
    z = arrz(idxz);
    if z >= 0
        Fz = ifftshift(ifft2(fftshift(invF.*exp(1i*2*pi*z*sqrt(1/lambda^2 - kr.^2)))));
    else
        Fz = ifftshift(ifft2(fftshift(invF.*conj(exp(1i*2*pi*abs(z)*sqrt(1/lambda^2 - kr.^2)))))); % Is this right?????
    end

    imagesc(abs(Fz).^2);
    axis square;
    title(['z = ' num2str(z*1e6) 'um']);
    drawnow;
    pause(0.5);

end