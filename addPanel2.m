function Panel = addPanel2(hFig)

h1 = 0.5;
h2 = 0.4;
h3 = 1-h1-h2;

%% View
Panel.Date.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [0, h2+h3, 1, h1], ...
                                'Title', 'Date',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'w',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'k');

%% tumor
Panel.Phase.hPanel = uipanel('parent', hFig,...
                                'Unit', 'Normalized',...
                                'Position', [0, h3, 1, h2], ...
                                'Title', 'Phase',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'visible',                      'on', ...
                                'ForegroundColor',       'w',...
                                'BackgroundColor',       'k', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'k');

%% profile
Panel.Button.hPanel = uipanel('Parent',                    hFig,...    
                                'Title',                        '',...
                                'FontSize',                 12,...
                                'Units',                     'normalized', ...
                                'Position',                  [0, 0,  1, h3],...
                                    'visible',                      'on', ...
                                'ForegroundColor',       'w',...
                                'BackgroundColor',       'black', ...
                                'HighlightColor',          'c',...
                                'ShadowColor',            'black');                            