function [y] = apply_distort(x, gain, dry)
%DISTORT Summary of this function goes here
%   Detailed explanation goes here
norm = x ./ abs(x);
y = norm .* (1 - exp(gain * norm .* x));
y = dry * x + (1 - dry) * y;
end

