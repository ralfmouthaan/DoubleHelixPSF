clc; clear variables; close all;

Ly=0.0096; %x-side length (m)
Lx=0.01536; %y-side length (m)
Mx=1920; %number of samples in x
My=1200; %number of samples in y
dx=Lx/Mx; %sample interval in x (m)
dy=Ly/My; %sample interval in x (m)
lambda=0.532*10^(-6); %wavelength (m)
k=2*pi/lambda; %wavenumber

x=-Lx/2:dx:Lx/2-dx; %x coordinates
y=-Ly/2:dy:Ly/2-dy; %x coordinates
[X,Y]=meshgrid(x,y); %X and Y grid coords

fx=-1/(2*dx):1/Lx:1/(2*dx)-1/Lx; %freq coords
fy=-1/(2*dy):1/Ly:1/(2*dy)-1/Ly;
[FX,FY]=meshgrid(fx,fy);
alpha=20;
Rpup=0.5*Ly;
mask=alpha*(cos(pi.*Y/Rpup)+0.5*sin(pi.*X/Rpup));

mask = (mask-min(min(mask)));
mask = mask/max(max(mask))*25;
mask = mod(mask, 1);

figure(3)
imagesc(fx,fy,abs(mask))
colormap('gray'); %linear gray display map
axis image;

imwrite(abs(mask),'TwinAiryMask.bmp','bmp')