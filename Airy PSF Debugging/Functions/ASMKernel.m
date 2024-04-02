% Ralf Mouthaan
% University of Adelaide
% February 2024
%
% Script to calculate ASM kernel

function K = ASMKernel(x, z, lambda)

    % Coord calculations
    Nx = length(x);
    dx = x(2) - x(1);
    kx = linspace(-1/dx/2, 1/dx/2, Nx); % Do I need a factor of 2pi in here?
    kr = sqrt(kx.^2 + kx.'.^2);
    %Kernel(kr > 1/lambda) = 0;
    %Kernel(lambda^2*kr.^2 > 1) = 0;
    %Kernel(abs(Kernel) < 1e-10) = 0;

    % Kernel calculation
    K = exp(1i*2*pi*abs(z)*sqrt(1/lambda^2 - kr.^2));

    if z < 0
        K = conj(K);
    end

end