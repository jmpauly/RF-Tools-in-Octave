function [aca] = b2a(bc);

n = length(bc);
% calculate minimum phase alpha
bcp = bc;
bcp(512) = 0;
bf = fft(bcp);
bfmax = max(abs(bf));
if bfmax>=1.0,                % PM can result in abs(beta)>1, not physical
  bf = bf/(0.00001 + bfmax);  %   we scale it so that abs(beta)<1 so that
end;                          %   alpha will be analytic
afa = ansigm(sqrt(1-bf.*conj(bf)));
aca = fft(afa)/512;
aca = real(aca(1:n));


