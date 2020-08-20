function Callback_Pushbutton_ImgSet1Panel_Load(src, evnt)

global hFig hFig2

data = guidata(hFig);

idx_Gate = data.selected.GateTableIndex;
idx_Date = data.selected.DateTableIndex;

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
        load(ffn_SS);
    else
        fun_readSS(data.ImgInfo.PatientID, SSPath, matPath);
        fun_readCT(data.ImgInfo.PatientID, dcmPath, matPath);
    end
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



%% load image data
td = tempdir;
fd_info = fullfile(td, 'STROM');
fn_info = fullfile(fd_info, 'info.mat');
if ~exist(fd_info, 'dir')
    PatientPath = uigetdir();
    if PatientPath ~=0
        mkdir(fd_info);
        DataPath = fileparts(PatientPath);
        save(fn_info, 'DataPath');
    end
else
    if ~exist(fn_info, 'file')
        PatientPath = uigetdir();
        if PatientPath ~=0
            DataPath = fileparts(PatientPath);
            save(fn_info, 'DataPath');
        end
    else
        load(fn_info);
        PatientPath = uigetdir(DataPath);
    end
end

if PatientPath ~=0
    [~, PatientID] = fileparts(PatientPath);
    [junk, DataPathName] = fileparts(DataPath);
    Mat.Path = fullfile(junk, [DataPathName, '_MatData'], PatientID);
    Mat.PathInfoFileName = fullfile(Mat.Path, 'PathInfo');
    
    if exist(Mat.Path, 'dir')
        load(Mat.PathInfoFileName);
        nDate = length(fd_allDates);
    else
        mkdir(Mat.Path);
        fd_allDates = fun_getAllSubFolders(PatientPath);
        nDate = length(fd_allDates);
        hWB = waitbar(0, 'Exploring image folders...');
        for iDate = 1:nDate
            fd_allGates{iDate} = fun_getAllSubFolders(fullfile(fd_allDates(iDate).folder, fd_allDates(iDate).name));
            modality{iDate} = fun_getDateModality(fd_allGates{iDate});
            waitbar(iDate/nDate, hWB, 'Exploring image folders...');
        end
        waitbar(1, hWB, 'Bingo!');
        pause(1);
        close(hWB)
        save(Mat.PathInfoFileName, 'fd_allDates', 'fd_allGates', 'modality');
    end
    data.ImgInfo.fd_allDates = fd_allDates;
    data.ImgInfo.fd_allGates = fd_allGates;

    data.ImgInfo.Mat = Mat;
    
    % fill table
    tableData = cell(nDate, 3);
    for iDate = 1:nDate
        tableData{iDate, 1} = false;
        tableData{iDate, 2} = fd_allDates(iDate).name;
        tableData{iDate, 3} = modality{iDate};
    end
    
    tableData{data.selected.DateTableIndex, 1} = true; % first date selected
        
    data2 = guidata(hFig2);
    data2.Panel.Date.Comp.Table.Date.Data = tableData;
        
    guidata(hFig, data);
    guidata(hFig2, data2);
    
    fillGateTable(data.selected.GateTableIndex);
    
    hFig2.Name = PatientID;
    hFig2.Visible = 'on';

    data.Panel.ImgSet1.Comp.Text.Date.String =  tableData{data.selected.DateTableIndex, 2};
    
    junk = ['Gated ', num2str(data.selected.GateTableIndex-1)];
    data.Panel.Gate.Comp.Text.Date.String =  junk;
    
    guidata(hFig, data)
    
end
    
    
    %     hWB = waitbar(0, 'Loading Images...');
% 
%     ffn = fullfile(PatientPath, matFile);
%     load(ffn)
% 
%     %%%%%%%%%%%%%%%%%%%%%%%
%     % tumor
%     data.Tumor.gatedContour = gatedContour;
%     data.Tumor.trackContour = trackContour;
%     data.Tumor.refContour = refContour;
%     data.Panel.Tumor.Comp.Pushbutton.Init.Enable = 'on';
%     %%%%%%%%%%%%%%%%%%%%%%%
% 
%     data.FileInfo.DataPath = PatientPath;
%     data.FileInfo.MatFile = matFile;
% 
%     %% load image info
%     Image.Images = imgWrite;
%     nImages = length(imgWrite);
%     [mImgSize, nImgSize, ~] = size(imgWrite{1});
%     Image.mImgSize = mImgSize;
%     Image.nImgSize = nImgSize;
%     Image.nImages = nImages;
% 
%     Image.indSS = 1:nImages;
%     Image.SliderValue = 1;
%     Image.FreeHandSlice = [];
% 
%     Image.GatedContour = gatedContour;
%     Image.TrackContour = trackContour;
%     Image.RefContour = refContour;
%     % image info
%     Image.x0 = 0;
%     Image.y0 = 0;
% 
%     Image.FoV = str2num(data.Panel.LoadImage.Comp.hEdit.ImageInfo(1).String);
%     Image.dx = Image.FoV/nImgSize;
%     Image.dy = Image.dx;
% 
%     data.Image = Image;
% 
%     data.Panel.LoadImage.Comp.hEdit.ImageInfo(2).String = num2str(nImgSize);
%     data.Panel.LoadImage.Comp.hEdit.ImageInfo(2).ForegroundColor = 'c';
% 
%     data.Panel.LoadImage.Comp.hEdit.ImageInfo(3).String = num2str(Image.dx);
%     data.Panel.LoadImage.Comp.hEdit.ImageInfo(3).ForegroundColor = 'c';
% 
%     % check previously saved snakes
%     [~, fn1, ~] = fileparts(matFile);
%     ffn_snakes = fullfile(PatientPath, [fn1, '_Snake.mat']);
%     data.FileInfo.ffn_snakes = ffn_snakes;
%     if exist(ffn_snakes, 'file')
%         data.Panel.LoadImage.Comp.Pushbutton.LoadSnake.Enable = 'on';
%     end
%     
%     % ffn_points
%     ffn_points = fullfile(PatientPath, [fn1, '_Point.mat']);
%     data.FileInfo.ffn_points = ffn_points;
% 
%     % ffn_measureData
%     ffn_measureData = fullfile(PatientPath, [fn1, '_measureData.mat']);
%     data.FileInfo.ffn_measureData = ffn_measureData;
%     ffn_measureDataFig = fullfile(PatientPath, [fn1, '_measureDataFig']);
%     data.FileInfo.ffn_measureDataFig = ffn_measureDataFig;
%     data.FileInfo.ffn_PointData = fullfile(PatientPath, [fn1, '_PointData.csv']);
%     
%     data.Snake.Snakes = cell(nImages, 1);
%     
%     % enable buttons
%     data.Panel.Snake.Comp.Pushbutton.FreeHand.Enable = 'on';
%     data.Panel.Snake.Comp.Pushbutton.StartSlice.Enable = 'on';
%     data.Panel.Snake.Comp.Pushbutton.EndSlice.Enable = 'on';
%     data.Panel.Snake.Comp.Edit.StartSlice.String = '1';
%     data.Panel.Snake.Comp.Edit.EndSlice.String = num2str(nImages);
%     data.Panel.Snake.Comp.Edit.StartSlice.ForegroundColor = 'r';
%     data.Panel.Snake.Comp.Edit.EndSlice.ForegroundColor = 'r';
% 
%     waitbar(1/3, hWB, 'Initializing View...');
% 
%     % CT images
%     sV = 1;
%     nImages = data.Image.nImages;
% 
%     I = rot90(Image.Images{sV}, 3);
%     [M, N, ~] = size(I);
% 
%     x0 = Image.x0;
%     y0 = Image.y0;
%     dx = Image.dx;
%     dy = Image.dy;
%     xWL(1) = x0-dx/2;
%     xWL(2) = xWL(1)+dx*N;
%     yWL(1) = y0-dy/2;
%     yWL(2) = yWL(1)+dy*M;
%     RA = imref2d([M N], xWL, yWL);
%     data.Image.RA = RA;
% 
%     hA = data.Panel.View.Comp.hAxis.Image;
%     hPlotObj.Image = imshow(I, RA, 'parent', hA);
%     axis(data.Panel.View.Comp.hAxis.Image, 'tight', 'equal')
% 
%     % snake
%     hPlotObj.Snake = line(hA,...
%         'XData', [], 'YData', [], 'Color', 'm', 'LineStyle', '-', 'LineWidth', 3);
%     hPlotObj.SnakeMask = line(hA,...
%         'XData', [], 'YData', [], 'Color', 'm', 'LineStyle', '-', 'LineWidth', 1);
% 
%     % point on diaphragm
%     hPlotObj.Point = line(hA,...
%         'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', 'none',...
%         'Marker', '.', 'MarkerSize', 24);
% 
%     hPlotObj.LeftPoints = line(hA,...
%             'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', 'none',...
%             'Marker', '.', 'MarkerSize', 16);
% 
%     hPlotObj.RightPoints = line(hA,...
%             'XData', [], 'YData', [], 'Color', 'g', 'LineStyle', 'none',...
%             'Marker', '.', 'MarkerSize', 16);
% 
%     data.Panel.View.Comp.hPlotObj = hPlotObj;
% 
%     % slider
%     hSS = data.Panel.SliceSlider.Comp.hSlider.Slice;
%     hSS.Min = 1;
%     hSS.Max = nImages;
%     hSS.Value = sV;
%     hSS.SliderStep = [1 10]/(nImages-1);
% 
%     data.Panel.SliceSlider.Comp.hText.nImages.String = [num2str(sV), ' / ', num2str(nImages)];
% 
%     waitbar(1, hWB, 'All slices are loaded!');
%     pause(2);
%     close(hWB);
% 
%     % contrast
%     yc = histcounts(I, max(I(:))+1);
%     yc = log10(yc);
%     yc = yc/max(yc);
%     xc = 1:length(yc);
%     xc = xc/max(xc);
% 
%     data.Panel.ContrastBar.Comp.hPlotObj.Hist.XData = xc;
%     data.Panel.ContrastBar.Comp.hPlotObj.Hist.YData = yc;
% 
%     data.Snake.SlitherDone = false;
%     data.Point.InitDone = false;
%     data.Tumor.InitDone = false;
% 
%     guidata(hFig, data);
%     
%     % tumor profile
%     Callback_Pushbutton_TumorPanel_Init;
%     
% end