function [y] = apply_distort(x, gain, dry)
% Summary
%   x = input signal
%   gain = "amount" of desired distortion
%   dry = percent of input signal to be contained in the final mix
norm = x ./ abs(x);

% Apply filter to signal and return final mix
y = norm .* (1 - exp(gain * norm .* x));
y = dry * x + (1 - dry) * y;
end

