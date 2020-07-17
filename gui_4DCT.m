function gui_4DCT

%% global 
global hFig hFig2
% global stopSlither
% global reContL
% global contrastRectLim

%% main window
hFig = figure('MenuBar',            'none', ...
                    'Toolbar',              'none', ...
                    'HandleVisibility',  'callback', ...
                    'Name',                'STROM 4DCT - Department of Radiation Oncology, Washington University in St. Louis', ...
                    'NumberTitle',      'off', ...
                    'Units',                 'normalized',...
                    'Position',             [0.2 0.1 0.75 0.8],...
                    'Color',                 'black', ...
                    'CloseRequestFcn', @figCloseReq_gui_4DCT, ...
                    'Visible',               'on');

addToolbar(hFig);
                 
data.Panel = addPanel(hFig);
data.Panel.Patient.Comp = addComponents2Panel_Patient(data.Panel.Patient.hPanel);
% data.Panel.View.Comp = addComponents2Panel_View(data.Panel.View.hPanel);
% data.Panel.Snake.Comp = addComponents2Panel_Snake(data.Panel.Snake.hPanel);
% data.Panel.ContrastBar.Comp = addComponents2Panel_ContrastBar(data.Panel.ContrastBar.hPanel);
% data.Panel.SliceSlider.Comp = addComponents2Panel_SliceSlider(data.Panel.SliceSlider.hPanel);
% 
% data.Panel.Point.Comp = addComponents2Panel_Point(data.Panel.Point.hPanel);
% data.Panel.Tumor.Comp = addComponents2Panel_Tumor(data.Panel.Tumor.hPanel);
% 
% data.Panel.About.Comp = addComponents2Panel_About(data.Panel.About.hPanel);
% 
% data.FC = [255 255 102]/255;
% 
guidata(hFig, data);
% 
%% point fig
hFig2 = figure('MenuBar',            'none', ...
                    'Toolbar',              'none', ...
                    'HandleVisibility',  'callback', ...
                    'Name',                'STROM 4DCT Image Info', ...
                    'NumberTitle',      'off', ...
                    'Units',                 'normalized',...
                    'Position',             [0.05 0.1 0.15 0.8],...
                    'Color',                 'black', ...
                    'CloseRequestFcn', @figCloseReq_ImgInfo, ...
                    'Visible',               'on');

data2.Panel = addPanel2(hFig2);
data2.Panel.Date.Comp = addComponents2Panel2_Date(data2.Panel.Date.hPanel);
% data2.Panel.Tumor.Comp = addComponents2Panel2_Tumor(data2.Panel.Tumor.hPanel);
% data2.Panel.Button.Comp = addComponents2Panel2_Button(data2.Panel.Button.hPanel);
% data2.Panel.Profile.Comp = addComponents2Panel2_Profile(data2.Panel.Profile.hPanel);
guidata(hFig2, data2);
