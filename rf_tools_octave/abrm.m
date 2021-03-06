function [a b] = abrm(rf,g,x,y)

%
%  [a b] = abrm(rf,g,[x [,y])
%
%  simulate an rf pulse, returning the Cayley-Klein parameters, alpha and
%  beta. This is the .m file version of abr(), which is compiled and faster.
%

%
%  Written by John Pauly, Dec 22, 2000
%  (c) Boaard of Trustees, Leland Stanford Jr. University
%

if (nargin == 2),
  x = g;
  g = ones(length(rf),1)*2*pi/length(rf);
  y = 0;
elseif (nargin == 3),
  y = 0;
endif;

lx = length(x);
ly = length(y);

a = zeros(lx,ly);
b = zeros(lx,ly);

for jj = 1:length(y),	
  for kk = 1:length(x),
    om = x(kk)*real(g) + y(jj)*imag(g);
    phi = sqrt(rf.^2+om.^2);
    n = [real(rf)./phi imag(rf)./phi om./phi] ;

    av = cos(phi/2) - i * n(:,3).* sin(phi/2);
    bv = -i*(n(:,1)+i*n(:,2)).*sin(phi/2);
    abt = [1; 0];
    for m=1:length(phi),
      abt = [av(m) -conj(bv(m)); bv(m) conj(av(m))] * abt;
    end;
    a(kk,jj) = abt(1);
    b(kk,jj) = abt(2);
  end;
end;

if (nargout == 1),
  a = [a b];
end;




