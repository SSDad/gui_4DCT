function Callback_Pushbutton_ImgSet1Panel_Load(src, evnt)

global hFig hFig3
global selected

data = guidata(hFig);
data3 = guidata(hFig3);

idx_Gate = selected.GateTableIndex;
idx_Date = selected.DateTableIndex;

gateString = ['Gated ', num2str(idx_Gate-1)];
matPath = fullfile(data.ImgInfo.Mat.Path, gateString);

if ~exist(matPath, 'dir')
    mkdir(matPath);
end

allGates = data.ImgInfo.fd_allGates{idx_Date};
allGatesName = {allGates.name}';
ind = find(contains(allGatesName,  gateString));

if length(ind) == 1
    dcmPath =  fullfile(allGates(ind).folder, allGates(ind).name);
    junk_fn = dir(fullfile(dcmPath, '*.dcm'));
    junk_di = dicominfo(fullfile(junk_fn.folder, junk_fn.name));
    
else
    junk_path =  fullfile(allGates(ind(1)).folder, allGates(ind(1)).name);
    junk_path2 =  fullfile(allGates(ind(2)).folder, allGates(ind(2)).name);
    junk_fn = dir(fullfile(junk_path, '*.dcm'));
    junk_di = dicominfo(fullfile(junk_fn(1).folder, junk_fn(1).name));
    if strcmp(junk_di.Modality, 'CT')
        dcmPath = junk_path;
        SSPath = junk_path2;
    else
        dcmPath = junk_path2;
        SSPath = junk_path;
    end
    
    ffn_CT = fullfile(matPath, [data.ImgInfo.PatientID, '_initialCT.mat']);
    ffn_CTxyz = fullfile(matPath, [data.ImgInfo.PatientID, '_CTxyz.mat']);
    ffn_CTinfo = fullfile(matPath, [data.ImgInfo.PatientID, '_CTinfo.mat']);
    ffn_SS = fullfile(matPath, [data.ImgInfo.PatientID, '_SS.mat']);
    
    if exist(ffn_CT, 'file')
        load(ffn_CT);
    else
        [CT] = fun_readCT(data.ImgInfo.PatientID, dcmPath, matPath);
    end
    
    if exist(ffn_SS, 'file')
        load(ffn_SS);
    else
        [SS] = fun_readSS(data.ImgInfo.PatientID, SSPath, matPath);
    end
    
    % view - CT
    hA = data.Panel.View.Comp.hA(1:3);
    hPlotObj = data.Panel.View.Comp.hPlotObj;
    [selected.ImgSet1.sliceInd] = load3View(CT, hA, hPlotObj);
    
    % view - structure
    [hPlotObj.SS] = initStruct(SS, hA, data3.Panel);
    hFig3.Visible = 'on';
    
    data.Panel.View.Comp.hPlotObj = hPlotObj;
    data.CT = CT;
    data.SS = SS;
    guidata(hFig, data);
end



% if exist(ffn_CT, 'file')
% else    
%     allGates = data.ImgInfo.fd_allGates{idx_Date};
%     allGatesName = {allGates.name}';
%     ind = find(contains(allGatesName,  gateString));
%     
%     if length(ind) == 1
%         dcmPath =  fullfile(allGates(ind).folder, allGates(ind).name);
%     else
%         junk_path =  fullfile(allGates(ind(1)).folder, allGates(ind(1)).name);
%         junk_path2 =  fullfile(allGates(ind(2)).folder, allGates(ind(2)).name);
%         junk_fn = dir(fullfile(junk_path, '*.dcm'));
%         junk_di = dicominfo(fullfile(junk_fn(1).folder, junk_fn(1).name));
%         if strcmp(junk_di.Modality, 'CT')
%             dcmPath = junk_path;
%             SSPath = junk_path2;
%         else
%             dcmPath = junk_path2;
%             SSPath = junk_path;
%         end
%         fun_readSS(data.ImgInfo.PatientID, SSPath, matPath);
%     end
%     fun_readCT(data.ImgInfo.PatientID, dcmPath, matPath);
%         
% end