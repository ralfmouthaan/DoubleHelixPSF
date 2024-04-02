% Ralf Mouthaan
% University of Adelaide
% February 2024
%
% This uses a double Fourier transform approach to do the Fresnel
% approximation calculation. As per Latchevskaia "Practical
% Algorithms for Simulation and Reconstruction of Digital In-Line
% Holograms", Applied Optics, 54 (9) 2015.

function [F, x] = propFresnel2(F, x, lambda, z)

    F = Conv2_FFT(F, FresnelKernel(x, z, lambda));

end