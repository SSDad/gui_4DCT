function  [hPO] = initStruct(SS, hA, Panel)

%% Fill SS Table
nS = length(SS.structures);
tableData.Struct = cell(nS, 1);
for iS = 1:nS
    sCLR = dec2hex(SS.contourColor{iS});
    sCLR_Char = reshape(sCLR', 1, 6);
    tableData.Struct{iS, 2} = ['<html><font color =' sCLR_Char '>' SS.Names{iS} '</font></html>'];
    tableData.Struct{iS, 1} = false;
end

Panel.List.Comp.Table.List.Data = tableData.Struct;

%% view
for iA = 1:length(hA)
    for iS = 1:nS
        hPO(iA).Struct(iS) = line(hA(iA), 'XData', [], 'YData', [],  'Color', SS.contourColor{iS}/255, 'LineStyle', '-');
    end
end
    

%     set(data_main.hTable.SS, 'Data', tableData.Struct, 'Visible',   'on');
% data_main.hPanel.SS.Visible = 'on';