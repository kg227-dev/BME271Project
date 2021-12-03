% Code for envelope
% a, d, and r can be [0 1000], s is [0 1]
% Sometimes this breaks when adjusting variables, but 
% works again without changing anything on second run?
% Adjustable values to be convolved with sounds

%[trumpet,fs_trumpet] = audioread('/Users/Jake/BME271/Final Project/BME271Project/trumpet-C4.wav');
[trumpet,fs_trumpet] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/trumpet-C4.wav');
%[violin,fs_violin] = audioread('/Users/Jake/BME271/Final Project/BME271Project/violin-C4.wav');
[violin,fs_violin] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/violin-C4.wav');
%piano,fs_piano] = audioread('/Users/Jake/BME271/Final Project/BME271Project/piano-C4.wav');
[piano,fs_piano] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/piano-C4.wav');
%[flute,fs_flute] = audioread('/Users/Jake/BME271/Final Project/BME271Project/flute-C4.wav');
[flute,fs_flute] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/flute-C4.wav');

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

t = 0:dt:3.2;
td = dt:dt:d/1000;
tr = dt:dt:r/1000;

% Make the envelope
% Plot xq, vq to visualize this
x = [0 a/1000 (a+d)/1000 (a+d+s)/1000 (a+d+r+s)/1000];
y = [0 1 samp samp 0];
xq = 0:dt:3.2;
vq = interp1(x, y, xq);

%ttrumpet = [0:1/fs_trumpet:length(trumpet)/fs_trumpet];
ttrumpet = (0:1/fs_trumpet:(length(trumpet)-1)/fs_trumpet);
%tviolin = [0:1/fs_violin:length(violin)/fs_violin];
tviolin = (0:1/fs_violin:(length(violin)-1)/fs_violin);
%tpiano = [0:1/fs_piano:length(piano)/fs_piano];
tpiano = (0:1/fs_piano:(length(piano)-1)/fs_piano);
%tflute = [0:1/fs_flute:length(flute)/fs_flute];
tflute = (0:1/fs_flute:(length(flute)-1)/fs_flute);


% Amplitudes of harmonics
h1 = 0.01;
h2 = 0.02;
h3 = 0.04;
h4 = 0.05;
h5 = 0.03;
h6 = 0.05;
h7 = 0.03;
h8 = 0;

% f0 for C4
f0 = 261.6;
% Test sound
test = h1 * cos(2*pi*f0*t) + h2 * cos(4*pi*f0*6) + h3 * cos(6*pi*f0*t) + ...
    h4 * cos(8*pi*f0*t) + h5 * cos(10*pi*f0*t) + h6 * cos(12*pi*f0*t) + ...
    h7 * cos(14*pi*f0*t) + h8 * cos(16*pi*f0*t);

% Play test sound with envelope
soundsc(test .* vq, fs)

%% Plot Envelope
subplot(2,2,1)
plot(tpiano, piano)
subplot(2,2,2)
plot(xq, vq)
ylim([0 1.2])
xlim([0 3.2])
subplot(2,2,3)
plot(trumpet.*vq)