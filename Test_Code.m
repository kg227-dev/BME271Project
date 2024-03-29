% Code for envelope
% a, d, s, and r can be [0 1000], samp is [0 1]
% Adjustable values to be dot multiplied with sounds (adsr envelope)

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
% a + d + r + s < length of sound, ms (2600)
% samp < 1
% Params to adjust 
a = input('Attack time, ms: ');
d = input('Decay time, ms: ');
s = input('Sustain time, ms: ');
r = input('Release time, ms: ');
samp = input('Sustain Amplitude (between 0 and 1): ');

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

norm_test = test / max(test);
test_ft = fftshift(fft(test));
norm_test_ft = abs(test_ft) / max(abs(test_ft));
ft = linspace(-fs/2, fs/2, length(test_ft));

%fm = cos(2*pi*f0*t + 7*cos(4*pi*f0*t));
%soundsc(fm.^9, fs)
distorted = fuzz(test, fs);
soundsc(distorted, fs)
%% Play Sound?

% Play test sound with envelope
if bool == 'y'
    soundsc(test, fs)
end

%soundsc(test .* vq, fs)
%soundsc(piano_clip, fs)

%% Plot Envelope
figure(1)
sgtitle('Gnarly Sound Stats', 'FontWeight', 'bold')
subplot(3,2,1)
plot(t, norm_test)
xlim([0 2.6])
title('{\it RAW} Sound, Time Domain')
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

subplot(3,2,2)
plot(ft, norm_test_ft)
xlim([0 2200])
title('{\it RAW} Sound, Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude, Normalized')

subplot(3, 2, 3)
plot(xq, vq)
xlim([0 2.6])
ylim([0 1.05])
title('{\it NASTY} Envelope')
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

subplot(3, 2, 4)
plot(t, norm_test)
hold on
plot(t, norm_test .* vq)
hold off
xlim([0 2.6])
title('{\it RAW} Sound with {\it NASTY} envelope') 
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

subplot(3, 2, [5, 6])
plot(t, norm_test)
xlim([0 200/fs])
title('{\it RAW} Sound, Zoomed In!')
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

