function [x,z,eps_lep]=EPS_LEP(x,z,u,w,overlap)

% The Format of the data is :
% size(u) = [vmap rows, vmap cols, number of v maps]
% size(x) = [vmap rows, vmap cols], z is the same as x, x and z are
% coordinates of the velocity vectors
% THE UNIT OF VELOCITY AND COORDINATES ARE CM and CM/S NOT M and M/S, if
% unit is M/s and M, you can change the 
% The Large eddy method first presented by Sheng(2001),
%
% By Sheng's analysis and argument, the turbulence dissipation rate can be
% approximated by computing the Reynolds averaged SGS dissipation rate
%
% $$\varepsilon \approx \langle\varepsilon_{SGS} \rangle = -2\langle\tau_{ij}
% \bar{S_{ij}}\rangle$$
%
% Where the resolved scale strain rate tensor defined as: $$\bar{S_{ij}}
% = \frac{1}{2}\Big( \frac{\partial{\bar{U_j}}}{\partial{x_i}}  + \frac{\partial{\bar{U_i}}}{\partial{x_i}}
% \Big)$$, which could be solved by
%
% The SGS stress $\tau_{ij}$ has to be closed by a model. Various SGS models
% have been proposed in the literature:
%
% # Smagorinsky model (Smagorisky,1963): $\tau_{ij} = -C_s^2\Delta^2|\bar{S}|\bar{S_{ij}}$,
% where $$C_s = 0.17$$ is constant. Too dissipate in naminar flow, but we expect
% the model to give good results in high Reynodls number turbulent flows, $\Delta$
% # Gradient model(Clark et al.(1979):$$\tau_{ij} = \frac{1}{12}\Delta^2\Big(
% \frac{\partial{\bar{U_i}}}{\partial{x_k}}\Big)\Big( \frac{\partial{\bar{U_j}}}{\partial{x_k}}\Big)$$
%
% We will use the 5 known parts to estimate the dissipation rate since the
% different parts are identical, so use the 2D result multiple 9/5.
%
% TKE estimation by Sheng(2000), by assuming the local isotropy at the resolved
% scales, that's normal, but how to solve the wave problem.
%
% $$k = \frac{3}{4}\sum_{i=1}^2 \langle(\bar{U_i} -\langle\bar{U_i}\rangle)^2\rangle$$
dx = mean(diff(x(1,:)));
eps_LEP = zeros(m,n);
delta = dx/(1-overlap); % means the x-correlation window size
for i = 1:N
    uu = u(:,:,i);
    ww = w(:,:,i);
    dx = mean(diff(x(1,:)));
    Cs=0.17;
    [U11,U13]=gradient(uu);  U11=U11/dx; U13=-U13/dx; % Gradient calculation
    [U31,U33]=gradient(ww);  U31=U31/dx; U33=-U33/dx;
    S = 9/5*(U11.^2+U33.^2+(U11+U33).^2+0.5*(U13+U31).^2);
    eps_LEP = eps_LEP +2*Cs^2*delta^2*S.^1.5;
end
eps_LEP = eps_LEP(3:end-2,3:end-2)/N/10000; % if lenght unit is m, remove the "/10000"
x = x(3:end-2,3:end-2);
z = z(3:end-2,3:end-2);

end