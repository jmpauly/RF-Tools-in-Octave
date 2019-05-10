function bn = b2mpkb(b,fa)

%
%  design a minimum peak power beta, given a prototype b
%
%    function bn = b2mpkb(b,fa)
%
%      b     -- prototype b
%      fa    -- flip angle
%

% calculate the B scale factor
scale = sin(fa/2);

% factor the prototype polynomial
hr = roots(b);

% locate and tag the passband zeros
[m n] = sort(angle(hr));
hrs = hr(n);
lmx = length(hrs);
uc = (abs(abs(hrs)-1) > 0.05).*[1:lmx]';
flp = [];
for jj=1:lmx, 
  if uc(jj) ~= 0
    flp = [flp; uc(jj)];
  end
end

% search over all possible flips, returns the polynomial roots
bnr = minpeakrfm(hrs,flp,scale);

bn = poly(bnr);
bn = bn*scale/max(fftcp(bn,256));
