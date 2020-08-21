function Callback_Pushbutton_PatientPanel_Patient(src, evnt)

global hFig hFig2
global selected

data = guidata(hFig);

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
    data.ImgInfo.PatientID = PatientID;
    data.ImgInfo.DataPath = DataPath;

    data.ImgInfo.Mat = Mat;
    
    % fill table
    tableData = cell(nDate, 3);
    for iDate = 1:nDate
        tableData{iDate, 1} = false;
        tableData{iDate, 2} = fd_allDates(iDate).name;
        tableData{iDate, 3} = modality{iDate};
    end
    
    tableData{selected.DateTableIndex, 1} = true; % first date selected
        
    data2 = guidata(hFig2);
    data2.Panel.Date.Comp.Table.Date.Data = tableData;
        
    guidata(hFig, data);
    guidata(hFig2, data2);
    
    fillGateTable(selected.GateTableIndex);
    
    hFig2.Name = PatientID;
    hFig2.Visible = 'on';

    data.Panel.ImgSet1.Comp.Text.Date.String =  tableData{selected.DateTableIndex, 2};
    
    junk = ['Gated ', num2str(selected.GateTableIndex-1)];
    data.Panel.Gate.Comp.Text.Date.String =  junk;
    
    guidata(hFig, data)
    
end
    
    
