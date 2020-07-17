function [modality] = fun_getDateModality(fd_allGates)

iGate = 1;%:length(fd_allDates)
junk = dir(fullfile(fd_allGates(iGate).folder, fd_allGates(iGate).name));
allFiles  = junk(~[junk.isdir]);
iFile = 1;%:length(allFiles)
dinfo = dicominfo(fullfile(allFiles(iFile).folder, allFiles(iFile).name));
if strcmp(dinfo.Modality, 'CT')
    if strcmp(dinfo.ManufacturerModelName, 'Pinnacle3')
        modality = 'CT';
    elseif  strcmp(dinfo.ManufacturerModelName, 'Trilogy Cone Beam CT')
        modality = 'CB';
    end
elseif strcmp(dinfo.Modality, 'RTSTRUCT')
    modality = 'CT';
end