function [MM, SOPI_UID, xx, yy, zz, dateCreated, ipp, ps] = fun_readCTImage(fld, fn)

    hWB = waitbar(0, 'Reading CT images...');
    for iFile = 1:numel(fn)
        I = dicomread(fullfile(fld, fn{iFile}));
        M(:,:,iFile) = I;
        dcmInfo = dicominfo(fullfile(fld, fn{iFile}));
        IPP(:, iFile) = dcmInfo.ImagePositionPatient;
        SOPI_UID{iFile} = dcmInfo.SOPInstanceUID;

        waitbar(iFile/numel(fn), hWB, 'Reading CT images...');
        
    end
    close(hWB);
    
    ipp = dcmInfo.ImagePositionPatient;    
    ps = dcmInfo.PixelSpacing;
    dateCreated = dcmInfo.InstanceCreationDate;
    nRows = double(dcmInfo.Rows);
    nColumns = double(dcmInfo.Columns);
    dx = dcmInfo.PixelSpacing(1);
    dy = dcmInfo.PixelSpacing(2);
    x0 = ipp(1);
    y0 = ipp(2);
    xx = x0:dx:x0+dx*(nRows-1);
    yy = y0:dy:y0+dy*(nColumns-1);

    z = IPP(3, :);
    [zz idx] = sort(z, 'descend');
    MM = M(:, :, idx);
    SOPI_UID = SOPI_UID(idx);