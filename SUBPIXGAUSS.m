function [vector] = SUBPIXGAUSS(result_conv, interrogationarea, x, y, z, SubPixOffset)
% For the function lakepiv use
xi = find(~((x <= (size(result_conv,2)-1)) & (y <= (size(result_conv,1)-1)) & (x >= 2) & (y >= 2)));

x(xi) = [];
y(xi) = [];
z(xi) = [];

xmax = size(result_conv, 2);
vector = NaN(size(result_conv,3), 2);

if(numel(x)~=0)
    ip = sub2ind(size(result_conv), y, x, z);
    %assignin('base','ip',ip);
    %the following 8 lines are copyright (c) 1998, Uri Shavit, Roi Gurka, Alex Liberzon, Technion � Israel Institute of Technology
    %http://urapiv.wordpress.com
    f0 = log(result_conv(ip));
    f1 = log(result_conv(ip-1));
    f2 = log(result_conv(ip+1));
    peaky = y + (f1-f2)./(2*f1-4*f0+2*f2);
    f0 = log(result_conv(ip));
    f1 = log(result_conv(ip-xmax));
    f2 = log(result_conv(ip+xmax));
    peakx = x + (f1-f2)./(2*f1-4*f0+2*f2);
    
    SubpixelX=peakx-(interrogationarea/2)-SubPixOffset;
    SubpixelY=peaky-(interrogationarea/2)-SubPixOffset;
    assignin('base','SubpixelX',SubpixelX);
    vector(z, :) = [SubpixelX, SubpixelY];
   
end
