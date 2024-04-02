% Ralf Mouthaan
% University of Adelaide
% February 2024
%
% Script to calculate Fresnel kernel as per Latchevskaia "Practical
% Algorithms for Simulation and Reconstruction of Digital In-Line
% Holograms", Applied Optics, 54 (9) 2015.

function K = FresnelKernel(x, z, lambda)

    % Coord calculations
    Nx = length(x);
    dx = (max(x) - min(x))/(Nx-1);
    du = 1/(Nx*dx);
    u = (-(Nx/2-1/2):(Nx/2-1/2))*du;
    [u_mesh, v_mesh] = meshgrid(u, u);

    % Kernel calculation
    K = exp(-1i*pi*lambda*z*(u_mesh.^2 + v_mesh.^2));

end