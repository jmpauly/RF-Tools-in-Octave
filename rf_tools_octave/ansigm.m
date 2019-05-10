% ansigm - take the magnitude of the fft of a signal, and return the
%   fft of the analytic signal.
%
% as = ansigm(ms)
%   as - fft of analytic signal
%   ms - magnitude of analytic signal fft.
%

function [a] = ansigm(x)
n = length(x);
xl = log(x);
xlf = fft(xl);
xlfp = zeros(1,n);
xlfp(1) = xlf(1);
xlfp(2:(n/2)) = 2*xlf(2:(n/2));
xlfp((n/2+1)) = xlf((n/2+1));
xlfp((n/2+2):n) = 0*xlf((n/2+2):n);
xlaf = ifft(xlfp);
a = exp(xlaf);


