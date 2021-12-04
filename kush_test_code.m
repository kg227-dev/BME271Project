% Code for envelope
% a, d, and r can be [0 1000], s is [0 1]
% Sometimes this breaks when adjusting variables, but 
% works again without changing anything on second run?
% Adjustable values to be convolved with sounds
%% Clear everything
clear all; clf; close all;
%% Read Audio

%[trumpet,fs_trumpet] = audioread('/Users/Jake/BME271/Final Project/BME271Project/trumpet-C4.wav');
[trumpet,fs_trumpet] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/trumpet-C4.wav');
%[violin,fs_violin] = audioread('/Users/Jake/BME271/Final Project/BME271Project/violin-C4.wav');
[violin,fs_violin] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/violin-C4.wav');
%[piano,fs_piano] = audioread('/Users/Jake/BME271/Final Project/BME271Project/piano-C4.wav');
[piano,fs_piano] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/piano-C4.wav');
%[flute,fs_flute] = audioread('/Users/Jake/BME271/Final Project/BME271Project/flute-C4.wav');
[flute,fs_flute] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/flute-C4.wav');

%% Envelope
% a + d + r + s < length of sound, ms
% samp < 1
% Params to adjust 
a = 100;
d = 100;
s = 200;
r = 2000;
samp = 0.8;

fs = 11025;
dt = 1/fs;

t = 0:dt:2.6;
td = dt:dt:d/1000;
tr = dt:dt:r/1000;

% Make the envelope
% Plot xq, vq to visualize this
x = [0 a/1000 (a+d)/1000 (a+d+s)/1000 (a+d+r+s)/1000];
y = [0 1 samp samp 0];
xq = 0:dt:2.6;
vq = interp1(x, y, xq);

%% Clip Sounds

trumpet_clip = transpose(trumpet(1:length(vq)));
violin_clip = transpose(violin(1:length(vq)));
piano_clip = transpose(piano(1:length(vq)));
flute_clip = transpose(flute(1:length(vq)));

%% Fourier Transform 

ft = fftshift(fft(piano_clip));
norm_ft = ft / max(ft);
tft = linspace(-fs/2, fs/2, length(norm_ft));

%% Play Sound
soundsc(piano_clip, fs)

%% Plot Envelope
subplot(2,2,1)
plot(t, piano_clip)
title('Time Domain Signal') 
subplot(2,2,2)
plot(tft, abs(norm_ft))
title('Frequency Domain Signal')
xlim([0 2200])

subplot(2,2,3)
plot(t, piano_clip)
hold on
plot(t,piano_clip.*vq)
hold off
title('Envelope Signal')
