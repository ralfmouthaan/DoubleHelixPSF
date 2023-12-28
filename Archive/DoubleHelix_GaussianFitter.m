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

clc; clear variables; close all;

%% Generate LG mode superposition

Nx = 1000;
x = linspace(-10,10,Nx);
F = zeros(Nx, Nx);

for n = 0:4
    F = F + LaguerreGaussBeam(n*4 + 1, n*2 + 1, x);
end

figure; 
imagesc(abs(F).^2);
colorbar;
axis square;

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

hold on
plot(ybar, xbar, 'rx');

%% Find width

% Find std dev

idx = 0;
for i = maxi - 10:maxi+10
    for j = maxj - 10:maxj + 10

        idx = idx + 1;
        ydata(idx) = log(abs(F(i, j)));
        xdata(idx) = (i - xbar)^2 + (j - ybar)^2;

    end
end

figure; plot(xdata, ydata, '.');

Y = ydata.';
X = xdata.';
X = [ones(size(X)) X];

b = pinv(transpose(X)*X)*transpose(X)*Y;
w0 = 1/abs(b(2));

yfit = b(1) + b(2)*xdata;
hold on
plot(xdata, yfit);

%% Generate mask

x = 1:size(F, 1);
y = 1:size(F, 2);
x = x.';

M = exp(-((x-xbar).^2 +(y-ybar).^2)/w0);
xbar = size(F, 1) - xbar;
ybar = size(F, 2) - ybar;
M = M + exp(-((x-xbar).^2 +(y-ybar).^2)/w0);

figure; 
imagesc(M);
axis square;

