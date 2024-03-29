clear
%% Construct New Sound Library
fs = 44100;
dt = 1/fs;
t = 0:dt:3;

keys = {'C3' 'Db3' 'D3' 'Eb3' 'E3' 'F3' 'Gb3' 'G3' 'Ab3' 'A3' 'Bb3' ...
    'B3' 'C4' 'Db4' 'D4' 'Eb4' 'E4' 'F4' 'Gb4' 'G4' 'Ab4' 'A4' ...
    'Bb4' 'B4' 'C5'};

freqs = [130.81 138.59 146.83 155.56 164.81 174.61 185.00 196.00 ...
    207.65 220.00 233.08 246.94 261.63 277.18 293.66 311.13 329.63 ...
    349.23 369.99 392.00 415.30 440.00 466.16 493.88 523.25];	

% % Amplitudes of harmonics (trumpet)
% h1 = 0.31;
% h2 = 0.45;
% h3 = 0.78;
% h4 = 1;
% h5 = 0.35;
% h6 = 0.83;
% h7 = 0.4;
% h8 = 0.25;

% Amplitudes of harmonics (piano)
h1 = 1;
h2 = 0.7;
h3 = 0.1;
h4 = 0.12;
h5 = 0;
h6 = 0.12;
h7 = 0.03;
h8 = 0.05;

% Create a structure, notes_in, that stores input signal information for 
% notes between C3 and C5
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

% % Ex. 1
% a = 50;
% d = 50;
% s = 300;
% r = 200;
% samp = 0.4;

% Ex. 2
a = 1000;
d = 1000;
s = 500;
r = 50;
samp = 0.01;

% Make the envelope
% Plot xq, vq to visualize this
% Code is copied directly from apply_adsr()
x = [0 a/1000 (a+d)/1000 (a+d+s)/1000 (a+d+r+s)/1000];
y = [0 1 samp samp 0];
xq = t;
vq = fillmissing(interp1(x, y, xq), 'constant', 0);

% Display Envelope (alone) Graphically
env = c4_in.*vq;
env = env / max(env);
%% LFO

% % Ex. 1
% hz = 1.5;
% amp = 0.5;

% Ex. 2
hz = 8;
amp = 0.5;

% Display LFO (alone) Graphically
lfo_test = apply_lfo(t, c4_in, amp, hz);

%% Distortion

% % Ex. 1
% gain = 2;
% dry = 0.5;

% Ex. 2
gain = 0.2;
dry = 0;

% Display Distortion (alone) Graphically
dstort = apply_distort(c4_in, gain, dry);
dstort = dstort / max(abs(dstort));

%% Mega Function - combine all of the different features

% % Just ADSR
% for idx = 1:length(keys)
%     notes_out.(keys{idx}) = add_effects(t, notes_in.(keys{idx}), ...
%          'adsr', [a d s r samp]);
% end
%
% % Just LFO
% for idx = 1:length(keys)
%     notes_out.(keys{idx}) = add_effects(t, notes_in.(keys{idx}), ...
%          'amp', amp, 'hz', hz);
% end
%
% % Just Distortion
% for idx = 1:length(keys)
%     notes_out.(keys{idx}) = add_effects(t, notes_in.(keys{idx}), ...
%          'gain', gain, 'dry', dry);
% end
% %
%All
for idx = 1:length(keys)
    notes_out.(keys{idx}) = add_effects(t, notes_in.(keys{idx}), ...
         'adsr', [a d s r samp], 'gain', gain, 'dry', dry, 'amp', amp, ...
         'hz', hz);
end

% Again, save a note for plotting
c4 = notes_out.C4;
big_test_norm = c4 / max(abs(c4));

%% Kush Sound

kush = [notes_out.A4(1:fs/2) notes_out.Db4(1:fs/2) notes_out.A4(1:fs/2) ...
    notes_out.Ab4(1:fs/2) notes_out.Db4(1:fs/2) notes_out.Ab4(1:fs/2) ...
    notes_out.Gb4(1:fs/2) notes_out.B3(1:fs/2) notes_out.Gb4(1:fs/2) ...
    notes_out.Gb4(1:fs/2) notes_out.F4(1:fs/2)];

kush_low = [notes_out.Gb3(1:3*fs/2) notes_out.Db3(1:3*fs/2) ...
    notes_out.D3(1:3*fs/2) notes_out.Db3(1:2*fs/2)];

kush_sound = kush + kush_low;
kush_sound = kush_sound / max(abs(kush_sound));
%% Play Sound?

bool = input("Play Sound? If yes, enter 'y': ", 's');

if bool == 'y'
    bool2 = input("Test, or Kush's Sound? Enter 'kush', 'test', or 'test, no fx': ", 's');
    if strcmp(bool2, 'kush')
        soundsc(kush_sound, fs)
    end
    if strcmp(bool2, 'test')
        soundsc(c4, fs)
    end
    if strcmp(bool2, 'test, no fx')
        soundsc(c4_in, fs)
    end
end

%% Plots

% Plot Original Signal in Time Domain, Zoomed In to See Individual Periods
figure(1)
sgtitle('Sound Stats', 'FontWeight', 'bold')
subplot(5,2,1)
plot(t, norm_test, 'r-')
xlim([0 800/fs])
title('Input Sound, Time Domain')
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

% Plot Original Signal in Frequency Domain
subplot(5,2,2)
plot(ft, norm_test_ft, 'r-')
xlim([0 2200])
ylim([0 1.2])
title('Input Sound, Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude, Normalized')

% Plot Envelope in Time Domain
subplot(5, 2, 3)
plot(xq, vq, 'r-')
xlim([0 2.6])
ylim([0 1.05])
title('Envelope')
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

% Plot Signal with All Effects, Zoomed Out, Time Domain
subplot(5, 2, 4)
plot(t, big_test_norm, 'r-')
title('Sound + All Effects')
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

% Plot Signal + Envelope, Zoomed In
subplot(5, 2, [5,6])
plot(t, env, 'r-')
title('Sound + Envelope, Zoomed In')
xlim([0 1600/fs])
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

% Plot Signal + Distortion, Zoomed In
subplot(5, 2, [7, 8])
plot(t, dstort, 'r-')
title('Sound + Distortion, Zoomed In')
xlim([0 1600/fs])
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

% Plot Signal with All Effects, Zoomed In
subplot(5, 2, [9,10])
plot(t, big_test_norm, 'r-')
title('Sound All Effects, Zoomed In')
xlim([0 1600/fs])
xlabel('Time (s)')
ylabel('Amplitude, Normalized')

if strcmp(bool2, 'kush')
    t_kush = 0:dt:(length(kush_sound)/fs) - dt;
    figure(2)
    plot(t_kush, kush_sound, 'r-')
    title("Kush's NEW Sound")
    xlabel('Time (s)')
    ylabel('Amplitude, Normalized')
end
