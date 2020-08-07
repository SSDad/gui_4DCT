function Comp = addComponents2Panel_AxialView(hPanel)

% axes
hA = axes('Parent',                   hPanel, ...
                            'color',        'none',...
                            'Units',                    'normalized', ...
                            'HandleVisibility',     'callback', ...
                            'Position',                 [0.05 0.05 0.9 0.9]);

hPlotObj.IA = imshow([], 'parent', hA);

hPlotObj.xLine = images.roi.Line(hA, 'Position',[0, 0; 0, 0], 'Color', 'r', 'LineWidth', 1);
addlistener(hPlotObj.xLine, 'MovingROI', @Callback_XHair_x);

hPlotObj.yLine = images.roi.Line(hA, 'Position',[0, 0; 0, 0], 'Color', 'g', 'LineWidth', 1);
addlistener(hPlotObj.yLine, 'MovingROI', @Callback_XHair_yOnAxialView);

hA.XAxisLocation='top';
hold(hA, 'on')

Comp.hAxis.Image = hA;
Comp.hPlotObj = hPlotObj;