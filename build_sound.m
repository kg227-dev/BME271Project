function [y] = build_sound(f0, t, h1, h2, h3, h4, h5, h6, h7, h8)
%BUILD_SOUND Summary of this function goes here
%   Detailed explanation goes here
y = h1 * cos(2*pi*f0*t) + h2 * cos(4*pi*f0*t) + h3 * cos(6*pi*f0*t) + ...
    h4 * cos(8*pi*f0*t) + h5 * cos(10*pi*f0*t) + h6 * cos(12*pi*f0*t) + ...
    h7 * cos(14*pi*f0*t) + h8 * cos(16*pi*f0*t);
end

