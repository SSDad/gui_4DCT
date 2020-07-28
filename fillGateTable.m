function fillGateTable

global hFig hFig2
data = guidata(hFig);
data2 = guidata(hFig2);

dateTableData = data2.Panel.Date.Comp.Table.Date.Data;

junk = cell2mat(dateTableData(:, 1));
 idx = find(junk, 1);

 fd_allGates = data.ImgInfo.fd_allGates{idx};
 nGate = length(fd_allGates);
 
 % fill table
 tableData = cell(nGate, 3);
 for iGate = 1:nGate
     tableData{iGate, 1} = false;
     tableData{iGate, 2} = fd_allGates(iGate).name;
%      tableData{iGate, 3} = modality{iGate};
 end
 
tableData{1, 1} = true; % first date selected

data2 = guidata(hFig2);
data2.Panel.Gate.Comp.Table.Gate.Data = tableData;

guidata(hFig2, data2);