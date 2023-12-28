% Ralf Mouthaan
% University of Adelaide
% December 2023
%
% Related to generating double helix point spread functions as per:
% Pavani & Piestun, "High-Efficiency Rotating Point Spread Functions",
% Optics Express, Vol. 16, No. 5, 2008
%
% This function generates the weighting mask used to emphasise the two
% dominant lobes. The masks consists of two Gaussians centred on the lobes
% and size-matched to the lobes. The lobes are assumed to be centered
% around the centre of the field.

function Mask = FitLobeMask(F)

    bolDebug = false;
    
    %% Find a peak
    
    % maxima are a rough indication of where the peaks are
    [maxi, maxj] = find(abs(F) == max(max(abs(F))));
    maxi = maxi(1); maxj = maxj(1);
    
    % Find peak using weighted average
    xbar = 0;
    ybar = 0;
    Fbar = 0;
    for i = maxi - 10:maxi + 10
        for j = maxj - 10:maxj + 10
            
            xbar = xbar + abs(F(i,j))*maxi;
            ybar = ybar + abs(F(i,j))*maxj;
            Fbar = Fbar + abs(F(i,j));
    
        end
    end
    
    xbar = xbar / Fbar;
    ybar = ybar / Fbar;
    
    if bolDebug
        hold on
        plot(ybar, xbar, 'rx');
    end
    
    %% Find lobe width
    
    % Collect datapoints around centroid
    idx = 0;
    for i = maxi - 10:maxi+10
        for j = maxj - 10:maxj + 10
    
            idx = idx + 1;
            ydata(idx) = log(abs(F(i, j)));
            xdata(idx) = (i - xbar)^2 + (j - ybar)^2;
    
        end
    end
    
    % Least squares regression
    Y = ydata.';
    X = xdata.';
    X = [ones(size(X)) X];
    b = pinv(transpose(X)*X)*transpose(X)*Y;
    w0 = 1/abs(b(2));
    
    if bolDebug
        yfit = b(1) + b(2)*xdata;
        figure;
        plot(xdata, ydata, '.');
        hold on
        plot(xdata, yfit);
    end
    
    %% Generate mask

    w0 = w0*1.5; % Make it slightly bigger???
    
    x = 1:size(F, 1);
    y = 1:size(F, 2);
    x = x.';
    
    % Assumes lobes are symmetric around centroid
    Mask = exp(-((x-xbar).^2 +(y-ybar).^2)/w0);
    xbar = size(F, 1) - xbar;
    ybar = size(F, 2) - ybar;
    Mask = Mask + exp(-((x-xbar).^2 +(y-ybar).^2)/w0);
    
    if bolDebug
        figure; 
        imagesc(Mask);
        axis square;
    end

end

