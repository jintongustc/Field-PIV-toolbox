function [tke_uu,tke_ww,tke_uw] = tke_structure(x,z,uin,win)

% The second order structure function method, the method first presented by
% William Alexander Nimmo-Smith(2002) applied in JHU under water PIV
% For reducing the wave contamination caused by instrument alignment
% The requirement of the method is that the distance of the dtructure
% function should be larger than the integral length scale but way smaller
% than the wave length. In my observation, the case 0023, I didn't see the
% converge
[m,n,N] = size(uin);
str_uu = zeros(m,n);
str_ww = zeros(m,n);
str_uw = zeros(m,n);

for i = 1:N
    u = uin(:,:,i);
    w = win(:,:,i);
    
    for j = 2:n
        str_uu(:,j) = str_uu(:,j) + (u(:,j)-u(:,3)).*(u(:,j)-u(:,3));
        str_ww(:,j) = str_ww(:,j) + (w(:,j)-w(:,3)).*(w(:,j)-w(:,3));
        str_uw(:,j) = str_uw(:,j) + (u(:,j)-u(:,3)).*(w(:,j)-w(:,3));
    end
end

str_uu = str_uu/N;
str_ww = str_ww/N;
str_uw = str_uw/N;

% plot the image of str_uu et.al
figure(10)
imagesc(x(1,:),z(:,1),str_uu)
colormap jet

figure(11)
hold on 
for i = 1:5:m
    plot(x(1,:),str_uu(i,:))
    pause(0.5)
end
hold off

tke_uu = mean(str_uu(:,end-3:end),2);
tke_ww = mean(str_ww(:,end-3:end),2);
tke_uw = mean(str_uw(:,end-3:end),2);

end