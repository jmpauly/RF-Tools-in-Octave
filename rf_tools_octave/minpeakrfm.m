function hnp = minpeakrfm(hp,flip,scale)

lflips = length(flip);
nflips = 2^lflips;

disp(sprintf('searching %d possible pulses',nflips));

msk = 2 .^[0:(lflips-1)];
rfmin = 1e6;

for jj=1:(nflips-1),
  fm = bitand(ones(1,lflips)*jj, msk);
  pr = hp;
  for ii=1:lflips,
    if fm(ii) ~= 0,
      pr(flip(ii)) = 1 ./conj(pr(flip(ii)));
    end;
  end;
  p = poly(pr);
  p = p*scale/sum(p);
  rf = b2rf(p.');
  if max(abs(rf)) < rfmin,
    rfmin = max(abs(rf));
    hnp = pr;
  end;
end

