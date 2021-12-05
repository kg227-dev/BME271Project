function [y] = apply_lfo(t, x, amp, hz)
% Summary
%   t = input time vector
%   x = input signal corresponsing to input time vector
%   amp = amplitude of peak undergoing oscillation in lfo
%   hz = frequency specified for lfo
place = 1 - amp * cos(2 * pi * hz * t);

% Apply lfo
y = place .* x;
y = y / max(y);
end

