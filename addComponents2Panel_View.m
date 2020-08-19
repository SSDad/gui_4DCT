function Comp = addComponents2Panel_View(hPanel)

x(1:3) = 0;
x(4:6) = 0.5;
y(1) = 2/3;  y(4) = y(1);
y(2) = 1/3;  y(5) = y(2);
y(3) = 0;  y(6) = y(3);
w(1:6) = 0.5;
h(1:6) = 1/3;

x(1) = 0; x(4) = x(1);
x(2) = 1/3; x(5) = x(2);
x(3) = 2/3; x(6) = x(3);
y(1:3) = 0.5;
y(4:6) = 0;
h(1:6) = 0.5;
w(1:6) = 1/3;

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

end

Comp.hSubPanel = hSubPanel;

% % axes
% hA = axes('Parent',                   hPanel, ...
%                             'color',        'none',...
%                             'Units',                    'normalized', ...
%                             'HandleVisibility',     'callback', ...
%                             'Position',                 [0.05 0.05 0.9 0.9]);
% 
% hPlotObj.IA = imshow([], 'parent', hA);
% 
% hPlotObj.xLine = images.roi.Line(hA, 'Position',[0, 0; 0, 0], 'Color', 'r', 'LineWidth', 1);
% addlistener(hPlotObj.xLine, 'MovingROI', @Callback_XHair_x);
% 
% hPlotObj.yLine = images.roi.Line(hA, 'Position',[0, 0; 0, 0], 'Color', 'g', 'LineWidth', 1);
% addlistener(hPlotObj.yLine, 'MovingROI', @Callback_XHair_yOnAxialView);
% 
% hA.XAxisLocation='top';
% hold(hA, 'on')
% 
% Comp.hAxis.Image = hA;
% Comp.hPlotObj = hPlotObj;