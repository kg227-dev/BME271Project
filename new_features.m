clear
%% Construct New Sound

fs = 44100;
dt = 1/fs;
t = 0:dt:3;

% Amplitudes of harmonics
h1 = 1;
h2 = 0.3;
h3 = 0.1;
h4 = 0.1;
h5 = 0;
h6 = 0.1;
h7 = 0.05;
h8 = 0.05;
bool = input("Play Sound? If yes, enter 'y': ", 's');

% f0 for C4
f0 = 261.6;

% Test sound(s)
c1_in = build_sound(32.70, t, h1, h2, h3, h4, h5, h6, h7, h8);
c3_in = build_sound(130.81, t, h1, h2, h3, h4, h5, h6, h7, h8);
c4_in = build_sound(f0, t, h1, h2, h3, h4, h5, h6, h7, h8);
eb4_in = build_sound(311.13, t, h1, h2, h3, h4, h5, h6, h7, h8);
g4_in = build_sound(392, t, h1, h2, h3, h4, h5, h6, h7, h8);

% Define Variables for Plotting Sound in Frequency Domain
norm_test = c4_in / max(c4_in);
test_ft = fftshift(fft(c4_in));
norm_test_ft = abs(test_ft) / max(abs(test_ft));
ft = linspace(-fs/2, fs/2, length(test_ft));

%% Envelope Params
a = 100;
d = 300;
s = 2500;
r = 50;
samp = 0.8;

% Make the envelope
% Plot xq, vq to visualize this
x = [0 a/1000 (a+d)/1000 (a+d+s)/1000 (a+d+r+s)/1000];
y = [0 1 samp samp 0];
xq = t;
vq = fillmissing(interp1(x, y, xq), 'constant', 0);

% Display Envelope (alone) Graphically
env = c4_in.*vq;
env = env / max(env);
%% LFO
hz = 4;
amp = 0.25;

% Display LFO (alone) Graphically
lfo_test = apply_lfo(t, c4_in, amp, hz);

%% Distortion
gain = 2;
dry = 0;

% Display Distortion (alone) Graphically
dstort = apply_distort(c4_in, gain, dry);

%% Mega Function

c1 = add_effects(t, c1_in, 'adsr', [a d s r samp], 'gain', gain, 'dry', dry, 'amp', amp, 'hz', hz);
c3 = add_effects(t, c3_in, 'adsr', [a d s r samp], 'gain', gain, 'dry', dry, 'amp', amp, 'hz', hz);
c4 = add_effects(t, c4_in, 'adsr', [a d s r samp], 'gain', gain, 'dry', dry, 'amp', amp, 'hz', hz);
eb4 = add_effects(t, eb4_in, 'adsr', [a d s r samp], 'gain', gain, 'dry', dry, 'amp', amp, 'hz', hz);
g4 = add_effects(t, g4_in, 'adsr', [a d s r samp], 'gain', gain, 'dry', dry, 'amp', amp, 'hz', hz);
big_test_norm = c4 / max(c4);

%% Play Sound?

% Play test sound with envelope
if bool == 'y'
    %soundsc(c4+eb4+g4, fs)
    soundsc(c1, fs)
end

%% Plot Envelope
figure(1)
sgtitle('Gnarly Sound Stats', 'FontWeight', 'bold')
subplot(5,2,1)
plot(t, norm_test)
xlim([0 800/fs])
title('{\it RAW} Sound, Time Domain')
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

subplot(5,2,2)
plot(ft, norm_test_ft)
xlim([0 2200])
title('{\it RAW} Sound, Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude, Normalized')

subplot(5, 2, 3)
plot(xq, vq, 'r-')
xlim([0 2.6])
ylim([0 1.05])
title('{\it NASTY} Envelope')
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

subplot(5, 2, 4)
plot(t, big_test_norm, 'r-')
title('Sound + {\it LAID-BACK} LFO')
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

subplot(5, 2, [5,6])
plot(t, env, 'r-')
title('Sound + {\it NASTY} Envelope, Zoomed In')
xlim([0 1600/fs])
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

subplot(5, 2, [7, 8])
plot(t, dstort, 'r-')
title('Sound + {\it DIRTY} Distortion, Zoomed In')
xlim([0 1600/fs])
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

subplot(5, 2, [9,10])
plot(t, big_test_norm, 'r-')
title('Sound + {\it ALL EFFECTS}, Zoomed In')
xlim([0 1600/fs])
xlabel('Time (s)')
ylabel('Amplitude, Normalized')


