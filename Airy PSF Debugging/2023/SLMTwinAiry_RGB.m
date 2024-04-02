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
R=sqrt(X.^2+Y.^2);

g1=zeros(Mx,My);
g1(R<0.0000001)=1;

figure(1)
imagesc(x,y,g1)
colormap('jet'); %linear gray display map
axis square; %square figure
axis xy %y positive up
xlabel('x (m)'); ylabel('y (m)');
xlim([-2*10^-4 2*10^-4]);
ylim([-2*10^-4 2*10^-4]);

dx=Lx/Mx; %sample interval
k=2*pi/lambda; %wavenumber

fx=-1/(2*dx):1/Lx:1/(2*dx)-1/Lx; %freq coords
fy=-1/(2*dy):1/Ly:1/(2*dy)-1/Ly;
[FX,FY]=meshgrid(fx,fy);
alpha=20;
Rpup=0.5*Ly;
masktwinairy=alpha*(cos(pi.*Y/Rpup)+0.5*sin(pi.*X/Rpup));





G1=fftshift(fft2(g1));

figure(2)
imagesc(fx,fy,abs(G1))
colormap('jet'); %linear gray display map
% axis square; %square figure
axis xy %y positive up

min(min(masktwinairy));
mask=(masktwinairy-min(min(masktwinairy)))/max(max(masktwinairy))/2;

figure(3)
imagesc(fx,fy,abs(mask))
colormap('jet'); %linear gray display map
% axis square; %square figure
axis xy %y positive up

imwrite(abs(mask),'TwinAiryMask.bmp','bmp')