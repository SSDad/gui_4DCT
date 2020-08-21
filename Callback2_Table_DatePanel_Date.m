function Callback2_Table_DatePanel_Date(src, evnt)

global hFig hFig2
data = guidata(hFig);
data2 = guidata(hFig2);

global selected;

idcs = evnt.Indices;
if ~isempty(idcs)
    oldIdx = selected.DateTableIndex;
    newIdx = idcs(1);
    selected.DateTableIndex = newIdx;
    src.Data{newIdx, 1} = true;
    if newIdx ~= oldIdx
        src.Data{oldIdx, 1} = false;
%         selected.idxSS = idcs(1);
%         src.Data{selected.idxSS, 1} = true; 
        
        data.selected = selected;
        guidata(hFig, data);
        
        fillGateTable(selected.GateTableIndex);
    end
end

% idx = find(junk1);
% src.Data{idx_old, 1} = false;
% src.Data{idx_new, 1} = true;


% hFig_main = ancestor(src, 'Figure');
% data_main = guidata(hFig_main);
% selected = data_main.selected;
% 
% idcs = evnt.Indices;
% if ~isempty(idcs)
%     oldIdx = selected.idxSS;
%     newIdx = idcs(1);
%     selected.idxSS = newIdx;
%     src.Data{newIdx, 1} = true;
% %     if idcs(1) == selected.idxSS
% %         set(data_main.hPlotObj.SS.z, 'visible', 'off')
% %         set(data_main.hPlotObj.SS.x, 'visible', 'off')
% %         set(data_main.hPlotObj.SS.y, 'visible', 'off')
% %     else
%     
%     if newIdx ~= oldIdx
%         src.Data{oldIdx, 1} = false;
% %         selected.idxSS = idcs(1);
% %         src.Data{selected.idxSS, 1} = true; 
%         
%         data_main.selected = selected;
%         guidata(hFig_main, data_main);
% 
%         set(data_main.hPlotObj.SS.z, 'visible', 'on')
%         set(data_main.hPlotObj.SS.x, 'visible', 'on')
%         set(data_main.hPlotObj.SS.y, 'visible', 'on')
%     
%         updateSS(hFig_main, '1', selected.iSlice.z);
%         updateSS(hFig_main, '2', selected.iSlice.x);
%         updateSS(hFig_main, '3', selected.iSlice.y);
%         
%         if strcmp(data_main.hMenuItem.AnalysisZ.Checked, 'on')
%             data_main = guidata(hFig_main);
%             updatePDF_zTime(data_main);
%             updateStat_zTime2d(data_main);
%             initializeStat_zTime3d(data_main);
%             updateStat_zTime3d(data_main);
%         elseif strcmp(data_main.hMenuItem.AnalysisZ_CBCT.Checked, 'on')
%             updatePDF_CBCT_zTime(data_main);            
%         end
%         
%         set(data_main.hMenuItem.jhZ, 'Checked', 'off')
%         set(data_main.hMenuItem.miZ, 'Checked', 'off')
%         for iSub = 1:4
%             set(data_main.hPlotObj.jhSub(iSub), 'CData', []); 
%         end
%         set(data_main.hPlotObj.Stat_zTime2d(7), 'xdata', [], 'ydata', [])
%         set(data_main.hPlotObj.StatSub_zTime2d(7), 'xdata', [], 'ydata', [])
% 
%     end
% end