function [y, vq] = apply_adsr(t, input, a, d, s, r, samp)
% Summary
%   t = input time vector
%   input = input signal corresponding to input time vector
%   a = duration of attack, ms
%   d = duration of decay, ms
%   s = duration of sustain, ms
%   r = duration of release, ms
%   samp = amplitude of sustain, between 0 and 1

% Store points of interest for the adsr filter in two arrays
x = [0 a/1000 (a+d)/1000 (a+d+s)/1000 (a+d+r+s)/1000];
y = [0 1 samp samp 0];

% Construct envelope from above arrays
vq = fillmissing(interp1(x, y, t), 'constant', 0);

% Apply filter to signal
y = input .* vq;
y = y / max(y);
end

