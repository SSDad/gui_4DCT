function Callback3_Table_SturctPanel_Title(src, evnt)

global selected
global hFig hFig2 hFig3
data = guidata(hFig);
data2 = guidata(hFig2);
data3 = guidata(hFig3);

viewInd = [1];
nS = length(data.SS.structures);
if selected.StructureTitle
    for iS = 1:nS
        data3.Panel.List.Comp.Table.List.Data{iS, 1} = false;
    end
    selected.StructureIndices = [];
    selected.StructureTitle = false;
else
    for iS = 1:nS
        data3.Panel.List.Comp.Table.List.Data{iS, 1} = true;
    end
    selected.StructureIndices = 1:nS;
    selected.StructureTitle = true;
end
updateSS(selected.StructureIndices, viewInd);