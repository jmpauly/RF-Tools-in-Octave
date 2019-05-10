clc

echo on

disp("Minimum and Maximum Phase RF Pulses");

%  The SLR designs so far have been linear phase:
%    They refocus perfectly
%    They can be used as spin echo pulses


%  If you don't care about phase, there are much more selective pulses:
%    Saturation pulses
%    Inversion pulses
%    Slab select pulses

%  These can be almost twice as selective as linear phase pulses.

%  You can design a minimum phase pulse by first designing a mimimum
%  phase beta, scaling it

bm = dzmp(256,8,0.001,0.001);
rfm = b2rf(bm);
t = [1:256]/32;
plot(t,real(rfscale(rfm,8)));
xlabel('time, ms');
ylabel('amplitude, kHz');

%  this is a 256 point pulse with a time-bandwidth of 8 (pulse duration
%  in ms multiplied by the slice width in kHz.  bm is scaled to a sum of 1,
%  so this is an inversion pulse

resp = input("Next?","s");

%  The linear phase inversion, from the previous demo is

bl = msinc(256,2);
rfl = b2rf(bl);

% This has the same time-bandwidth product

plot(t,real(rfscale(rfm,8)),t,real(rfscale(rfl,8)));
legend('minimum phase', 'linear phase');
xlabel('time, ms');
ylabel('amplitude, kHz');

resp = input("Next?","s");

%  We can compare the profiles as

x = [-64:64]/4;
mzm = ab2inv(abr(rfm,x));
mzl = ab2inv(abr(rfl,x));
plot(x,mzm,x,mzl);
legend("Minimum Phase ","Linear Phase");

resp = input("Next?","s");

%  Zooming in on the transition bands

axis([0 5 -1 1]);

resp = input("Next?","s");

%  This can be useful for other pulses, such as slab select pulses

%  Something to try:
%    Design a minimum phase excitation pulse (scale b to sqrt(2)/2)
%    Compare the complex excitation profile of the min phase pulse,
%      and a max phase pulse (min phase reversed in time).


