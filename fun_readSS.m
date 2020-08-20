function fun_readSS(MRN, fd_rs, fd_mat)

addpath(fullfile(pwd, 'getStructure'));

dcmFiles = dir(fullfile(fd_rs, '*.dcm'));

ffn = fullfile(fd_rs, dcmFiles.name);
rsInfo = dicominfo(ffn);
FrameOfReferenceUID = rsInfo.ReferencedFrameOfReferenceSequence.Item_1.FrameOfReferenceUID;
contourColor = structfun(@fun_getContourColor, rsInfo.ROIContourSequence);
plan = load_structure_from_dicom(ffn);
plan.structureData.contourColor = contourColor;
sNames = plan.structureData.names;

structures = plan.structureData.structures;

SSLabel = rsInfo.StructureSetLabel;
SSDate = rsInfo.StructureSetDate;

SSName = [];
if isfield(rsInfo, 'StructureSetName')
    SSName = rsInfo.StructureSetName;
end

%% save
fn = [MRN, '_', 'SS'];
ffn_struct = fullfile(fd_mat, fn);
save(ffn_struct, 'structures', 'sNames', 'contourColor', 'SSDate', 'SSName');

