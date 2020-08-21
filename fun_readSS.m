function [SS] = fun_readSS(MRN, fd_rs, fd_mat)

addpath(fullfile(pwd, 'getStructure'));

dcmFiles = dir(fullfile(fd_rs, '*.dcm'));

ffn = fullfile(fd_rs, dcmFiles.name);
rsInfo = dicominfo(ffn);
FrameOfReferenceUID = rsInfo.ReferencedFrameOfReferenceSequence.Item_1.FrameOfReferenceUID;
SS.contourColor = structfun(@fun_getContourColor, rsInfo.ROIContourSequence);
plan = load_structure_from_dicom(ffn);
% plan.structureData.contourColor = contourColor;

SS.Names = plan.structureData.names;

SS.structures = plan.structureData.structures;

SS.Label = rsInfo.StructureSetLabel;
SS.Date = rsInfo.StructureSetDate;

SS.SetName = [];
if isfield(rsInfo, 'StructureSetName')
    SS.SetName = rsInfo.StructureSetName;
end

%% save
fn = [MRN, '_', 'SS'];
ffn_struct = fullfile(fd_mat, fn);
save(ffn_struct, 'SS');