function[x,y,u,v] = lakepiv(A,B,minix,maxix,miniy,maxiy,interrogationarea,step)
% The PIV program was developed for the underwater PIV applied in the Lake
% Michigan
% The function was modified from PIVLAB, the algorithm is the simplest 
% one - one step cross correlation method

% SMAPLE SCRIPT
% clear all
% close all
% interrogationarea = 64;
% step = 32;
%
% miniy = 200;
% maxiy = 2000;
% minix = 350;
% maxix = 1100;
%
% A = double(imrotate(imread('Image0000A.jpg'),90));
% B = double(imrotate(imread('Image0000B.jpg'),90));
%
% [xtable,ytable,utable,vtable] = lakepiv(A,B,minix,maxix,miniy,maxiy...
%     ,interrogationarea,step);
%
% imagesc(A)
% colormap gray;
% hold on;
% quiver(xtable,ytable,utable,vtable,2);
% axis equal
% hold off;
%

minix = minix - interrogationarea/2;
maxix = maxix - interrogationarea/2;
miniy = miniy - interrogationarea/2;
maxiy = maxiy - interrogationarea/2;

[m,n]=size(A);

if (rem(interrogationarea,2) == 0) %for the subpixel displacement measurement
    SubPixOffset=1;
else
    SubPixOffset=0.5;
end


mm=floor((maxiy-miniy)/step+1);
nn=floor((maxix-minix)/step+1);

subpixfinder = 1; % 1 means gauss, 2 means gauss2D

s0 = (repmat((miniy:step:maxiy)'-1, 1,nn) + repmat(((minix:step:maxix)-1)*m, mm,1))';
s0 = permute(s0(:), [2 3 1]);
s1 = repmat((1:interrogationarea)',1,interrogationarea) + repmat(((1:interrogationarea)-1)*m,interrogationarea,1);
ss1 = repmat(s1, [1, 1, size(s0,3)])+repmat(s0, [interrogationarea, interrogationarea, 1]);

image1_cut = A(ss1);
image2_cut = B(ss1);

result_conv = fftshift(fftshift(real(ifft2(conj(fft2(image1_cut)).*fft2(image2_cut))), 1), 2);

minres = permute(repmat(squeeze(min(min(result_conv))), [1, size(result_conv, 1), size(result_conv, 2)]), [2 3 1]);
deltares = permute(repmat(squeeze(max(max(result_conv))-min(min(result_conv))),[ 1, size(result_conv, 1), size(result_conv, 2)]), [2 3 1]);
result_conv = ((result_conv-minres)./deltares)*255;

% assignin('base','corr',result_conv) % for tuning the program

[yt, xt, zt] = ind2sub(size(result_conv), find(result_conv==255));

% we need only one peak from each couple pictures
[z1, zi] = sort(zt);
dz1 = [z1(1); diff(z1)];
i0 = find(dz1~=0);
x1 = xt(zi(i0));
y1 = yt(zi(i0));
z1 = zt(zi(i0));

x = repmat((minix:step:maxix)+interrogationarea/2, length(miniy:step:maxiy), 1);
y = repmat(((miniy:step:maxiy)+interrogationarea/2)', 1, length(minix:step:maxix));

if subpixfinder==1
    [vector] = SUBPIXGAUSS (result_conv,interrogationarea, x1, y1, z1, SubPixOffset);
elseif subpixfinder==2
    [vector] = SUBPIX2DGAUSS (result_conv,interrogationarea, x1, y1, z1, SubPixOffset);
end
vector = permute(reshape(vector, [size(x') 2]), [2 1 3]);

u = vector(:,:,1);
v = vector(:,:,2);

return