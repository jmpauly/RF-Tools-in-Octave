function [rf] = b2rf(bc);

bc = bc(:);
n = length(bc);
% calculate minimum phase alpha
bcp = bc;
bcp(2048) = 0;
bf = fft(bcp);
bfmax = max(abs(bf));
if bfmax>=1.0,                % PM can result in abs(beta)>1, not physical
  bf = bf/(0.00001 + bfmax);  %   we scale it so that abs(beta)<1 so that
end;                          %   alpha will be analytic
afa = ansigm(sqrt(1-bf.*conj(bf))).';
aca = fft(afa)/2048;
acar = real(aca(n:-1:1));

% backsolve for rf
rf = cabc2rf(acar, bc);

