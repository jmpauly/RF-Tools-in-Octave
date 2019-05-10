
clc
echo on

disp(" Shinnar-Le Roux Pulse design demo");

%  The previous section showed how to simulate the profile of an RF pulse.
%  In this section we show how to design much better RF pulses.

%  The SLR design starts by designing the beta polynomial, which is a lowpass
%  function scalled to sine of half the flip angle.  For an inversion pulse, 
%  this is sin(pi/2) = 1;

%  We start with a windowed sinc again

b = msinc(256,2);

% This is scaled to 1, which is what we want.  We then design a consistent
% alpha, and then solve for the RF pulse. Alpha is determined uniquely 
% given that we want a minimum power pulse, so the result is

rf = b2rf(b);

% We will compare this to the windowed sinc scaled to pi,

rfw = b*pi;

% Compute the two responses as inversions.

x = [-64:64]/4;
mxy = ab2inv(abr(rf,x));
mxyw = ab2inv(abr(rfw,x));
plot(x,mxy,x,mxyw);
legend("slr","windowed sinc");

resp = input("Next?","s");

% Note the sharper profile of the SLR pulse.  This comes at a cost if we
% compare RF pulses

%  This comes at a cost if we compare RF pulses

t = [1:256]/32;
plot(t,rfscale(rf,8),t,rfscale(rfw,8));
legend("slr","windowed sinc");
xlabel('time, ms')
ylabel('amplitude, kHz')

% "The SLR pulse has almost twice the peak amplitude.


resp = input("Next?","s");

%  Something to try:
%    Look at how the RF pulses and profiles chance as the flip angle decreases
%    Scale b to sin(pi*0.99/2), sin(pi*0.95/2), sin(pi*0.9/2).


echo off
