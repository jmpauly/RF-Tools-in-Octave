
clc
echo on



disp("RF Pulse simulator Demo");

%  rf_tools has an RF pulse simulator that computes the rotations produced by
%  your rf pulses.

%  It does this using spinors, and the Cayley-Klein parameters alpha and beta.
%  These two complex numbers completely define a rotation.

%  Once the rotation has been computed, any RF profile can be computed.

%  First, we need an RF pulse

rf = msinc(256,2);

%  This is just a Hamming windowed sinc.

%  Normalize to pi/2

rf = rf*(pi/2)/sum(rf);
cplot(rf)

resp = input("Next:");

%  Next we need a vector of spatial locations.  By default the 
%  simulator assumes that the gradient area integrates to 2 pi over 
%  the pulse, so the spatial locations are multiples of 2 pi.

x = [-64:64]/4;

%  and then simulate the result

[a b] = abr(rf,x);

cplot(a)
title("Alpha:");
resp = input("Next:","s");


cplot(b)
title("Beta");
resp = input("Next:","s");

%  At this point we need to calculate something we care about from a and b

mxy_ex = ab2ex(a,b);
plot(x,abs(mxy_ex));
title("Excitation Profile");
resp = input("Next:","s");

mz_inv = ab2inv(a,b);
plot(x, real(mz_inv));
title("Inversion or Saturation Profile");
resp = input("Next:","s");

mxy_se = ab2se(a,b);
plot(x, real(mxy_se));
title("Spin-Echo Profile");
resp = input("Next:","s");

%  Not too surprising, a pi/2 pulse is not a great spin echo pulse.

%  Now we just need better RF pulses to simulate! That is next.

echo off



