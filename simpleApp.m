function app
% SIMPLEAPP Interactively explore plotting instruments
% Create figure window
fig = uifigure;
fig.Name = "My App";

% Manage app layout
gl = uigridlayout(fig,[3 3]);
gl.RowHeight = {30,'1x'};
gl.ColumnWidth = {'fit','1x'};

% Create UI components
lbl = uilabel(gl);
dd = uidropdown(gl);
ax = uiaxes(gl);
cbx = uibutton(gl);

% Lay out UI components
% Position label
lbl.Layout.Row = 1;
lbl.Layout.Column = 1;
% Position drop-down
dd.Layout.Row = 1;
dd.Layout.Column = 2;
% Position axes
ax.Layout.Row = [2 3];
ax.Layout.Column = [1 3];
% Position checkbox
cbx.Layout.Row = 1;
cbx.Layout.Column = 3;

% Configure UI component appearance
cbx.Text = "Play Sound";
lbl.Text = "Choose Instrument:";
dd.Items = ["Trumpet" "Piano" "Flute" "Violin"];
dd.Value = "Trumpet";
[trumpet,fs_trumpet] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/trumpet-C4.wav');
%[trumpet,fs_trumpet] = audioread('/Users/Jake/BME271/Final Project/BME271Project/trumpet-C4.wav');
t_trumpet = (0:1/fs_trumpet:(length(trumpet)-1)/fs_trumpet);
plot(ax,t_trumpet, trumpet);
title(ax,'Trumpet');
xlabel(ax, 'Time (s)');
% Assign callback function to drop-down
dd.ValueChangedFcn = {@changeInstrument,ax};
% Assign callback function to checkbox
cbx.ButtonPushedFcn = {@playSound};

end

% Program app behavior
function [type] = changeInstrument(src,event,ax)
type = event.Value;
switch type
    case "Trumpet"
        [trumpet,fs_trumpet] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/trumpet-C4.wav');
        t_trumpet = (0:1/fs_trumpet:(length(trumpet)-1)/fs_trumpet);
        plot(ax,t_trumpet,trumpet);
        title(ax,'Trumpet');
        xlabel(ax, 'Time (s)');
        soundsc(trumpet, fs_trumpet);
    case "Piano"
        [piano,fs_piano]=audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/piano-C4.wav');
        t_piano = (0:1/fs_piano:(length(piano)-1)/fs_piano);
        plot(ax,t_piano,piano);
        title(ax,'Piano');
        xlabel(ax, 'Time (s)');
        soundsc(piano, fs_piano);
    case "Flute"
        [flute,fs_flute]=audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/flute-C4.wav');
        t_flute = (0:1/fs_flute:(length(flute)-1)/fs_flute);
        plot(ax,t_flute,flute);
        title(ax,'Flute');
        xlabel(ax, 'Time (s)');
        soundsc(flute, fs_flute);
    case "Violin"
        [violin, fs_violin] = audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/violin-C4.wav');
        t_violin = (0:1/fs_violin:(length(violin)-1)/fs_violin);
        plot(ax,t_violin,violin);
        title(ax,'Violin');
        xlabel(ax, 'Time (s)');
        soundsc(violin, fs_violin);
end
end
function playSound(src, event)
[piano,fs_piano]=audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/BME271Project/piano-C4.wav');
soundsc(piano, fs_piano);
end

    


