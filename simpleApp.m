%% Music Plotting App
% Kush Gulati, Jake Spruance, Christian Chitty
function app

%% Create figure window
fig = uifigure;
fig.Name = "Instrument Profile";

%% Manage app layout
gl = uigridlayout(fig,[4 4]);
gl.RowHeight = {30,'1x'};
gl.ColumnWidth = {'fit','1x'};

%% Create UI components
lbl = uilabel(gl);
dd = uidropdown(gl);
ax = uiaxes(gl);
ax2 = uiaxes(gl);

%% Position label
lbl.Layout.Row = 1;
lbl.Layout.Column = 1;

%% Position drop-down
dd.Layout.Row = 1;
dd.Layout.Column = 2;

%% Position axes
ax.Layout.Row = [2 3];
ax.Layout.Column = [1 2];
ax2.Layout.Row = [2 3];
ax2.Layout.Column = [3 4];

%% Configure UI component appearance
lbl.Text = "Choose Instrument:";
lbl.FontSize = 14;
dd.Items = ["Trumpet" "Piano" "Flute" "Violin"];
dd.Value = "Trumpet";

%% Read in Audio
[trumpet,fs_trumpet] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/trumpet-C4.wav');
%[trumpet,fs_trumpet] = audioread('/Users/Jake/BME271/Final Project/BME271Project/trumpet-C4.wav');
t_trumpet = (0:1/fs_trumpet:(length(trumpet)-1)/fs_trumpet);

%% Plot Time Signal
plot(ax,t_trumpet, trumpet);
title(ax,'Trumpet: Time Domain');
xlabel(ax, 'Time (s)');
xlim(ax, [0.5 0.5+100/fs_trumpet])

%% Fourier Transform 
ft = fftshift(fft(trumpet));
norm_ft = ft / max(ft);
tft = linspace(-fs_trumpet/2, fs_trumpet/2, length(norm_ft));

%% Plot Frequency Signal
plot(ax2, tft, abs(norm_ft))
title(ax2,'Trumpet: Frequency Domain')
xlabel(ax2, 'Frequency (Hz)');
xlim(ax2,[0 2200])

%% Assign callback function to drop-down
dd.ValueChangedFcn = {@changeInstrument,ax,ax2};
end

%% Program app behavior
function [type] = changeInstrument(src,event,ax,ax2)
type = event.Value;
switch type
    
%% Trumpet Instrument
    case "Trumpet"
        [trumpet,fs_trumpet] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/trumpet-C4.wav');
        t_trumpet = (0:1/fs_trumpet:(length(trumpet)-1)/fs_trumpet);
        soundsc(trumpet, fs_trumpet)
        plot(ax,t_trumpet,trumpet);
        title(ax,'Trumpet: Time Domain');
        xlabel(ax, 'Time (s)');
        ft = fftshift(fft(trumpet));
        norm_ft = ft / max(ft);
        tft = linspace(-fs_trumpet/2, fs_trumpet/2, length(norm_ft));
        plot(ax2, tft, abs(norm_ft))
        title(ax2,'Trumpet: Frequency Domain')
        xlabel(ax2, 'Frequency (Hz)');     
%% Piano Instrument
    case "Piano"
        [piano,fs_piano]=audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/piano-C4.wav');
        t_piano = (0:1/fs_piano:(length(piano)-1)/fs_piano);
        soundsc(piano, fs_piano)
        plot(ax,t_piano,piano);
        title(ax,'Piano: Time Domain');
        xlabel(ax, 'Time (s)');
        ft = fftshift(fft(piano));
        norm_ft = ft / max(ft);
        tft = linspace(-fs_piano/2, fs_piano/2, length(norm_ft));
        plot(ax2, tft, abs(norm_ft))
        title(ax2,'Piano: Frequency Domain')
        xlabel(ax2, 'Frequency (Hz)');
%% Flute Instrument
    case "Flute"
        [flute,fs_flute]=audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/flute-C4.wav');
        t_flute = (0:1/fs_flute:(length(flute)-1)/fs_flute);
        soundsc(flute, fs_flute)
        plot(ax,t_flute,flute);
        title(ax,'Flute: Time Domain');
        xlabel(ax, 'Time (s)');
        ft = fftshift(fft(flute));
        norm_ft = ft / max(ft);
        tft = linspace(-fs_flute/2, fs_flute/2, length(norm_ft));
        plot(ax2, tft, abs(norm_ft))
        title(ax2,'Flute: Frequency Domain')
        xlabel(ax2, 'Frequency (Hz)');
%% Violin Instrument    
    case "Violin"
        [violin, fs_violin] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/violin-C4.wav');
        t_violin = (0:1/fs_violin:(length(violin)-1)/fs_violin);
        soundsc(violin, fs_violin)
        plot(ax,t_violin,violin);
        title(ax,'Violin: Time Domain');
        xlabel(ax, 'Time (s)');
        ft = fftshift(fft(violin));
        norm_ft = ft / max(ft);
        tft = linspace(-fs_violin/2, fs_violin/2, length(norm_ft));
        plot(ax2, tft, abs(norm_ft))
        title(ax2,'Violin: Frequency Domain')
        xlabel(ax2, 'Frequency (Hz)');
end
end


    


