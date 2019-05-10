clc

echo on

disp("2D Spiral Excitation Pulses");

%  2D spiral pulses can be designed for any flip angle using Fourier designs
%  The flip angle is the Fourier transform of the k-space weighting

%  An example design is an eight turn, 8 ms pulse with 1 G/cm gradient, and 
%  2 G/cm/ms slew rates (10 mT/m and 20 mT/m/s)

[rf g] = dz2d(8,1,4,512,1,2);

%  where the second argument is the spatial bandwidth in cycles/cm and
%  the fourth argument is the space-bandwidth product (like TBW for 1D pulses)

%  The pulse ends up being 8.2 ms.

t = [1:512]*8.205/512;

subplot(211);
plot(t, rf);
xlabel('time, ms');
title('RF Pulse');
subplot(212)
plot(t, real(g),t,imag(g))
xlabel('time, ms');
ylabel('G/cm');
title('Gx and Gy');

resp = input("Next?","s");

%  Next we want to simulate the excitation profile.  At this point it is scaled
%  to 1 radian.  To increase it to pi/2

rf = rf*pi/2;

%  The abr() simulator will take 2D pulses.  First define spatial vectors

x = [-32:32]/4;
y = [-32:32]/4;

mxy = ab2ex(abr(rf,g,x,y));

subplot(111);
mesh(abs(mxy));

resp = input("Next?","s");

% This RF pulse is well refocused at the end of the pulse

subplot(211);
mesh(real(mxy));
title('Mx');
subplot(212);
mesh(-imag(mxy));
title('-My');

resp = input("Next?","s");

%  We can simulate over a broader spatial range to visualize the sidelobes

subplot(211)
mxy4 = ab2ex(abr(rf,g,x*4,y*4));
subplot(211)
mesh(real(mxy4))
title('Mx, wide FOV');

subplot(212)
mesh(-imag(mxy4))
title('-My, wide FOV');

%  Note that the main lobe is imaginary, the first sidelobe is real, 
%  and the second sidelobe is imaginary.  Extra credit if you can explain 
%  this!

resp = input("Next?","s");

%  We can use the same pulse as a spin-echo pulse if we increase the flip 
%  angle, and make sure the gradients integrate to zero

rfse = rf*2;

rfse = [0; rf*2];
gse = [-sum(g); g];

mxyse = ab2se(abr(rfse,gse,x,y));

subplot(111);

mesh(real(mxyse));
title('My, Spin-echo Profile');

resp = input("Next?","s");

%  Things to try:
%    Change the space-bandwidth product to 6 or 8
%    Change the number of turns
%    Do a two shot experiment, where g = -g for the second shot.  Add Mxy's.
%    Use modern gradient numbers

echo off
