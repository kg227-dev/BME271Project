function [y, vq] = apply_adsr(t, input, a, d, s, r, samp)
%APPLY_ADSR Summary of this function goes here
%   Detailed explanation goes here
x = [0 a/1000 (a+d)/1000 (a+d+s)/1000 (a+d+r+s)/1000];
y = [0 1 samp samp 0];
vq = fillmissing(interp1(x, y, t), 'constant', 0);

y = input .* vq;
y = y / max(y);
end

