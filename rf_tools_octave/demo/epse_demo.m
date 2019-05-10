clc

echo on

disp("Echo Planar Spin Echo Pulses");

%  Echo planar excitation pulses turn up in 2D spatial pulses, and
%  spectral-spatial pulses.  Either way, for small flip angles, a 
%  Fourier design works.  Choose a subpulse that has the spatial
%  selectivity you want, and then design an n-point hard pulse for the
%  subpulse amplitudes

%  This doesn't work for large flip angle pulses.  The hard pulse direction
%  is inherently non-linear.  What we want is a unique SLR pulse in the slow 
%  direction for each flip angle in the fast (subpulse) direct.  dzepse.m does
%  this.

%  dzepse requires one gradient subpulse, so it can verse the RF.  We'll
%  assume it is flat

gx = ones(1,256)*2*pi/256;

%  A spin echo epse pulse can then be designed with

rfepse = dzepse(pi, gx, 4, 1, 16, 4);

This has 16 time-bandwidth 4, 1 ms sublobes



