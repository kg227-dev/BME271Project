function [y] = apply_lfo(t, x, amp, hz)
%LFO Summary of this function goes here
%   Detailed explanation goes here
place = 1 - amp * cos(2 * pi * hz * t);
y = place .* x;
y = y / max(y);
end

