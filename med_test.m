function[u,w,perc] =  med_test(u,w)
% EXAMPLE:
% load sample_vel
% for i  = 1:size(uu,3)
%     [uu(:,:,i),ww(:,:,i),perc]= med_test(uu(:,:,i),ww(:,:,i));
%     disp(perc)
% end
% the method was first presented by Jerry Westerweel (1994)and he modified
% the method by the new normalized version at 2005
% The suggestion is that filter the velocity before calibrate the velocity
% from pixel displacement to real displacement. The threshold here is for
% pixel
Thr = 2;  % The Threshold
[m,n] = size(u);
eps = 0.1; % estimated measurement noise level
u = padarray(u,[2 2],'symmetric','both');
w = padarray(w,[2 2],'symmetric','both');
perc = 0;
for i = 3:m+2
    for j = 3:n+2
        
        Neigh = u(i-2:i+2,j-2:j+2);
        Neigh2 = Neigh([1:12 14:25]);
        um = median(Neigh2(:));
        Res = abs(Neigh2 -um);
        MedianRes = median(Res);
        Fluct = abs(u(i,j)-um)/(MedianRes+eps);
        valu = Fluct < Thr;
        
        Neigh = w(i-2:i+2,j-2:j+2);
        Neigh2 = Neigh([1:12 14:25]);
        wm = median(Neigh2(:));
        Res = abs(Neigh2 -wm);
        MedianRes = median(Res);
        Fluct = abs(w(i,j)-wm)/(MedianRes+eps);
        valv = Fluct < Thr;
        
        if valu*valv == 0
            u(i,j) = um;
            w(i,j) = wm;
            perc=perc+1;
        end
    end
end

u = u(3:end-2,3:end-2);
w = w(3:end-2,3:end-2);
perc = perc/m/n;       % The prob of vecter replaced

end

