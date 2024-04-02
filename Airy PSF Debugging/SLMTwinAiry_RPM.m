% Ralf Mouthaan
% University of Adelaide
% March 2024
%
% Numerical propagation scripts to try to figure out what's going on with
% Ramses' PSF engineering project. In effect, he's getting a line on the
% camera that does not vary with depth instead of a twin airy PSF that does
% vary with depth.

clc; clear variables; close all;
addpath('Functions\')

%% User-Defined

Nx = 2048;
x = linspace(-10e-6, 10e-6, Nx); % FOV of 10um
BeadSize = 200e-9; % 200nm beads
lambda = 800e-9;
f_1 = 200e-3/40; % Focal length of 40x objective lens

%% Sample plane

F = exp(-(x.^2 + x.'.^2)/(BeadSize/2).^2);

F = propFresnel2(F, x, lambda, f_1);

figure; imagesc(x*1e6, x*1e6, abs(F));