function [x,z,eps_direct_1,eps_direct_2]=EPS_DIRECT(x,z,u,w)
% The Format of the data is :
% size(u) = [vmap rows, vmap cols, number of v maps]
% size(x) = [vmap rows, vmap cols], z is the same as x, x and z are
% coordinates of the velocity vectors
% 
% The dissipation calculation method is the Direct method, the equation is:

% * Direct estimation by j._o_hinze_turbulence_1987:$\[\varepsilon = 4\nu \Big[\Big
% \langle \Big (\frac{\partial u_1}{\partial x_1}\Big)^2\Big \rangle +\Big \langle
% \Big(\frac{\partial u_3}{\partial x_3}\Big)^2\Big \rangle +\Big \langle \frac{\partial
% u_1}{\partial x_1}\frac{\partial u_3}{\partial x_3}\Big \rangle +\frac{3}{4}\Big
% \langle \Big(\frac{\partial u_1}{\partial x_3} + \frac{\partial u_3}{\partial
% x_1} \Big) ^2 \Big \rangle \Big]\]$

% * Direct estimation by assuming the out-of-plane gradients are statistically
% equal to the in-plane gradients:$\[\varepsilon = 3\nu \Big[\Big \langle \Big
% (\frac{\partial u_1}{\partial x_1}\Big)^2\Big \rangle +\Big \langle \Big(\frac{\partial
% u_3}{\partial x_3}\Big)^2\Big \rangle + \Big \langle \Big(\frac{\partial u_3}{\partial
% x_1}\Big)^2\Big \rangle +\Big \langle \Big(\frac{\partial u_1}{\partial x_3}\Big)^2\Big
% \rangle +2\Big \langle \Big(\frac{\partial u_3}{\partial x_1}\frac{\partial
% u_1}{\partial x_3}\Big)\Big \rangle +\frac{2}{3}\Big \langle \Big(\frac{\partial
% u_1}{\partial x_1}\frac{\partial u_3}{\partial x_3}\Big)\Big \rangle\Big]\]$
%

% The viscosity of this case is in the temperature of  4 degree C, then the
% nv = 1.5e-6
[m,n]=size(x);
eps_direct_1 = zeros(m,n);
eps_direct_2 = zeros(m,n);
N = size(u,3); % N is the total number of velocity maps
for i = 1:N
    nv = 1.5e-6; % viscosity at 5 degree c
    dx = abs(mean(diff(x(1,:))));
    uu = u(:,:,i);
    ww = w(:,:,i);
    [dux,duz]=gradient(uu);  dux=dux/dx; duz=-duz/dx; % Gradient calculation
    [dwx,dwz]=gradient(ww);  dwx=dwx/dx; dwz=-dwz/dx;

    eps_direct_1_new = 4 * nv *...
        (dux.^2 + dwz.^2 + 0.75*duz.^2 + 0.75*dwx.^2 + 1.5*duz.*dwx + dux.*dwz);
    eps_direct_2_new = 3 * nv *...
        (dux.^2 + dwz.^2 + dwx.^2 + duz.^2 + 2*dwx.*duz + 2/3*dux.*dwz);

    eps_direct_1 = eps_direct_1 + eps_direct_1_new;
    eps_direct_2 = eps_direct_2 + eps_direct_2_new;
end
eps_direct_1 = eps_direct_1(3:end-2,3:end-2)/N;
eps_direct_2 = eps_direct_2(3:end-2,3:end-2)/N;
x = x(3:end-2,3:end-2);
z = z(3:end-2,3:end-2);

end