% Ralf Mouthaan
% University of Adelaide
% December 2023
%
% Angular spectrum method for propagating.

function Fz = PropagateZ(F, z, lambda, kr)

    invF = ifftshift(fft2(fftshift(F)));
    
    % Angular spectrum method for propagation
    if z >= 0
        Fz = ifftshift(ifft2(fftshift(invF.*exp(1i*2*pi*z*sqrt(1/lambda^2 - kr.^2)))));
    else
        Fz = ifftshift(ifft2(fftshift(invF.*conj(exp(1i*2*pi*abs(z)*sqrt(1/lambda^2 - kr.^2)))))); % Is this right?????
    end

end