[sound,fs]=audioread('/Users/kushgulati/Box Sync/Junior Year/BME271/Kush Gulati BME271 Lucid Dreams Marimba.mp3');

function app
% SIMPLEAPP Interactively explore plotting instruments



% Create figure window
fig = uifigure;
fig.Name = "My App";

% Manage app layout
gl = uigridlayout(fig,[2 2]);
gl.RowHeight = {30,'1x'};
gl.ColumnWidth = {'fit','1x'};

% Create UI components
lbl = uilabel(gl);
dd = uidropdown(gl);
ax = uiaxes(gl);

% Lay out UI components
% Position label
lbl.Layout.Row = 1;
lbl.Layout.Column = 1;
% Position drop-down
dd.Layout.Row = 1;
dd.Layout.Column = 2;
% Position axes
ax.Layout.Row = 2;
ax.Layout.Column = [1 2];

% Configure UI component appearance
lbl.Text = "Choose Plot Type:";
dd.Items = ["Trumpet" "Piano" "Flute" "Violet"];
dd.Value = "Surf";
surf(ax,peaks);

% Assign callback function to drop-down
dd.ValueChangedFcn = {@changePlotType,ax};
end

% Program app behavior
function changePlotType(src,event,ax)
type = event.Value;
switch type
    case "Trumpet"
        surf(ax,peaks);
    case "Piano"
        mesh(ax,peaks);
    case "Flute"
        waterfall(ax,peaks);
end
end