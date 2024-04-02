% Ralf Mouthaan
% University of Adelaide
% December 2023
%
% Angular spectrum method for propagating.

function Fz = propASM(F, x, lambda, z)

    Fz = Conv2_FFT(F, ASMKernel(x, z, lambda));

end