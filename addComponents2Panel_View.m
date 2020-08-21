function Comp = addComponents2Panel_View(hPanel)

% 3x2
x(1:3) = 0;
x(4:6) = 0.5;
y(1) = 2/3;  y(4) = y(1);
y(2) = 1/3;  y(5) = y(2);
y(3) = 0;  y(6) = y(3);
w(1:6) = 0.5;
h(1:6) = 1/3;

% 2x3
x(1) = 0; x(4) = x(1);
x(2) = 1/3; x(5) = x(2);
x(3) = 2/3; x(6) = x(3);
y(1:3) = 0.5;
y(4:6) = 0;
h(1:6) = 0.5;
w(1:6) = 1/3;

%% sub panel
for n = 1:6
    hSubPanel(n) = uipanel('parent', hPanel,...
                                'Unit', 'Normalized',...
                                'Position', [x(n), y(n), w(n), h(n)], ...
                                'Title', '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'k',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'k');


    % axes
    hA(n) = axes('Parent',                   hSubPanel(n), ...
                                'color',        'none',...
                                'Units',                    'normalized', ...
                                'HandleVisibility',     'callback', ...
                                'Position',                 [0.05 0.05 0.9 0.9]);

    hold(hA(n), 'on')
    
    hPlotObj.I(n) = imshow([], 'parent', hA(n));

end
hA(1).XAxisLocation='top';
hA(4).XAxisLocation='top';

%% ImgSet1
% Axial
hPlotObj.XHair(1).xLine = images.roi.Line(hA(1), 'Position',[0, 0; 0, 0], 'Color', 'r', 'LineWidth', 1);
addlistener(hPlotObj.XHair(1).xLine, 'MovingROI', @Callback_XHair_ImgSet1_x);

hPlotObj.XHair(1).yLine = images.roi.Line(hA(1), 'Position',[0, 0; 0, 0], 'Color', 'g', 'LineWidth', 1);
addlistener(hPlotObj.XHair(1).yLine, 'MovingROI', @Callback_XHair_ImgSet1_yOnAxialView);

% Sagital
hPlotObj.XHair(2).zLine = images.roi.Line(hA(3), 'Position',[0, 0; 0, 0], 'Color', 'b', 'LineWidth', 1);
addlistener(hPlotObj.XHair(2).zLine, 'MovingROI', @Callback_XHair_ImgSet1_z);

hPlotObj.XHair(2).yLine = images.roi.Line(hA(3), 'Position',[0, 0; 0, 0], 'Color', 'g', 'LineWidth', 1);
addlistener(hPlotObj.XHair(2).yLine, 'MovingROI', @Callback_XHair_ImgSet1_yOnSagitalView);


% Coronal
hPlotObj.XHair(3).zLine = images.roi.Line(hA(2), 'Position',[0, 0; 0, 0], 'Color', 'b', 'LineWidth', 1);
addlistener(hPlotObj.XHair(3).zLine, 'MovingROI', @Callback_XHair_ImgSet1_z);
                        
hPlotObj.XHair(3).xLine = images.roi.Line(hA(2), 'Position',[0, 0; 0, 0], 'Color', 'r', 'LineWidth', 1);
addlistener(hPlotObj.XHair(3).xLine, 'MovingROI', @Callback_XHair_ImgSet1_x);

%% ImgSet1

%% comp
Comp.hSubPanel = hSubPanel;
Comp.hA = hA;
Comp.hPlotObj = hPlotObj;

% 
% Comp.hAxis.Image = hA;
% Comp.hPlotObj = hPlotObj;