function Comp = addComponents2Panel_Gate(hPanel)

h_Gap = 0.05; 
nB = 2;
h_Button = (1-h_Gap*(nB+2))/nB;

BC_PB = [1 1 1]*0.25;
FS = 10;

% patient button
h = 1-h_Gap-h_Button;
Comp.Text.Date = uicontrol('parent', hPanel, ...
                                'Style', 'text',...
                                'String', '',...
                                'Unit', 'Normalized',...
                                'Position', [0.05 h 0.9 h_Button], ...
                                'FontSize', 10, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', BC_PB,...
                                'ForegroundColor', 'g',...
                                'Visible', 'on');
                            
% image info
h = h-h_Gap-h_Button;
Comp.Pushbutton.Load = uicontrol('parent', hPanel, ...
                                'Style', 'pushbutton',...
                                'String', 'Load',...
                                'Unit', 'Normalized',...
                                'Position', [0.2 h 0.6 h_Button], ...
                                'FontSize', FS, ...
                                'FontWeight', 'bold', ...
                                'BackgroundColor', BC_PB,...
                                'ForegroundColor', 'c',...
                                'Visible', 'off', ...
                                'Enable', 'on', ...
                                'Callback', @Callback_Pushbutton_ImgSet1Panel_Load);