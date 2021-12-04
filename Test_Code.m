% Code for envelope
% a, d, and r can be [0 1000], s is [0 1]
% Sometimes this breaks when adjusting variables, but 
% works again without changing anything on second run?
% Adjustable values to be convolved with sounds

%% Load Instruments

[trumpet,fs_trumpet] = audioread('/Users/Jake/BME271/Final Project/BME271Project/trumpet-C4.wav');
%[trumpet,fs_trumpet] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/trumpet-C4.wav');
[violin,fs_violin] = audioread('/Users/Jake/BME271/Final Project/BME271Project/violin-C4.wav');
%[violin,fs_violin] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/violin-C4.wav');
[piano,fs_piano] = audioread('/Users/Jake/BME271/Final Project/BME271Project/piano-C4.wav');
%[piano,fs_piano] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/piano-C4.wav');
[flute,fs_flute] = audioread('/Users/Jake/BME271/Final Project/BME271Project/flute-C4.wav');
%[flute,fs_flute] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/flute-C4.wav');

%% Envelope Params
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

trumpet_clip = transpose(trumpet(1:length(vq)));
violin_clip = transpose(violin(1:length(vq)));
piano_clip = transpose(piano(1:length(vq)));
flute_clip = transpose(flute(1:length(vq)));

%% Construct New Sound

% Amplitudes of harmonics
h1 = input('First Harmonic: ');
h2 = input('Second Harmonic: ');
h3 = input('Third Harmonic: ');
h4 = input('Fourth Harmonic: ');
h5 = input('Fifth Harmonic: ');
h6 = input('Sixth Harmonic: ');
h7 = input('Seventh Harmonic: ');
h8 = input('Eighth Harmonic: ');
bool = input("Play Sound? If yes, enter 'y': ", 's');

% f0 for C4
f0 = 261.6;

% Test sound
test = h1 * cos(2*pi*f0*t) + h2 * cos(4*pi*f0*t) + h3 * cos(6*pi*f0*t) + ...
    h4 * cos(8*pi*f0*t) + h5 * cos(10*pi*f0*t) + h6 * cos(12*pi*f0*t) + ...
    h7 * cos(14*pi*f0*t) + h8 * cos(16*pi*f0*t);

test_ft = fftshift(fft(test));
norm_test_ft = test_ft / max(test_ft);
ft = linspace(-fs/2, fs/2, length(test_ft));

% Play test sound with envelope
if bool == 'y'
    soundsc(test, fs)
end

%soundsc(test .* vq, fs)
%soundsc(piano_clip, fs)

%% Plot Envelope
subplot(2,2,1)
plot(tpiano, piano)
subplot(2,2,2)
plot(xq, vq)
ylim([0 1.2])
xlim([0 3.2])

figure(2)
plot(transpose(ttrumpet), trumpet)

figure(3)
plot(ft, abs(test_ft))
xlim([0 2200])
subplot(2,2,3)
plot(x,y)

figure(4)
plot(t, test)
hold on
plot(t, test.*vq)
hold off

