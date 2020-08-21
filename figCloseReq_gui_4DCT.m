function figCloseReq_gui_4DCT(src, callbackdata)

% Close all figures
global hFig2 hFig3
if ishandle(hFig2)
    delete(hFig2)
end

if ishandle(hFig3)
    delete(hFig3)
end

delete(src)


%    selection = questdlg('Close This Figure?',...
%       'Close Request Function',...
%       'Yes','No','Yes'); 
%    switch selection 
%       case 'Yes'
%          delete(gcf)
%       case 'No'
%       return 
%    end
% end