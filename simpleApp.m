function simpleApp
% SIMPLEAPP Interactively explore plotting functions
%   Choose the function used to plot the sample data to see the
%   differences between surface plots, mesh plots, and waterfall plots

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
dd.Items = ["Surf" "Mesh" "Waterfall"];
dd.Value = "Surf";
surf(ax,peaks);

% Assign callback function to drop-down
dd.ValueChangedFcn = {@changePlotType,ax};
end

% Program app behavior
function changePlotType(src,event,ax)
type = event.Value;
switch type
    case "Surf"
        surf(ax,peaks);
    case "Mesh"
        mesh(ax,peaks);
    case "Waterfall"
        waterfall(ax,peaks);
end
end