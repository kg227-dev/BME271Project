clear
%% Construct New Sound

fs = 44100;
dt = 1/fs;
t = 0:dt:3;

keys = {'C3' 'Db3' 'D3' 'Eb3' 'E3' 'F3' 'Gb3' 'G3' 'Ab3' 'A3' 'Bb3' ...
    'B3' 'C4' 'Db4' 'D4' 'Eb4' 'E4' 'F4' 'Gb4' 'G4' 'Ab4' 'A4' ...
    'Bb4' 'B4' 'C5'};

freqs = [130.81 138.59 146.83 155.56 164.81 174.61 185.00 196.00 ...
    207.65 220.00 233.08 246.94 261.63 277.18 293.66 311.13 329.63 ...
    349.23 369.99 392.00 415.30 440.00 466.16 493.88 523.25];	

% Amplitudes of harmonics
h1 = 1;
h2 = 0.7;
h3 = 1.25;
h4 = 0.15;
h5 = 0.15;
h6 = 0.1;
h7 = 0;
h8 = 0.02;

for idx = 1:length(keys)
    notes_in.(keys{idx}) = build_sound(freqs(idx), t, h1, h2, h3, h4, h5, h6, h7, h8);
end

% Save one note for plotting purposes
c4_in = notes_in.C4;

% Define Variables for Plotting Sound in Frequency Domain
norm_test = c4_in / max(c4_in);
test_ft = fftshift(fft(c4_in));
norm_test_ft = abs(test_ft) / max(abs(test_ft));
ft = linspace(-fs/2, fs/2, length(test_ft));

%% Envelope Params
a = 100;
d = 50;
s = 200;
r = 1000;
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
hz = 12;
amp = 0.25;

% Display LFO (alone) Graphically
lfo_test = apply_lfo(t, c4_in, amp, hz);

%% Distortion
gain = 2;
dry = 0;

% Display Distortion (alone) Graphically
dstort = apply_distort(c4_in, gain, dry);
dstort = dstort / max(abs(dstort));

%% Mega Function

% Full add-ons commented out for easy access
% notes_out.(keys{idx}) = add_effects(t, notes_in.(keys{idx}), ...
%         'adsr', [a d s r samp], 'gain', gain, 'dry', dry, 'amp', amp, ...
%         'hz', hz);


for idx = 1:length(keys)
    notes_out.(keys{idx}) = add_effects(t, notes_in.(keys{idx}), ...
         'adsr', [a d s r samp], 'gain', gain, 'dry', dry, 'amp', amp, ...
         'hz', hz);
end

% Again, save a note for plotting
c4 = notes_out.C4;
big_test_norm = c4 / max(abs(c4));

%% Play Sound?

bool = input("Play Sound? If yes, enter 'y': ", 's');

if bool == 'y'
    soundsc(notes_out.D3 + notes_out.Gb3 + notes_out.A3 + notes_out.Db4, fs)
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
ylim([0 1.2])
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
title('Sound + {\it ALL EFFECTS}')
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


