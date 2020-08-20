function fun_readCT(MRN, fd_ct, fd_mat)

%% dcmInfo
    fnList = dir(fd_ct);
    fnList=fnList(~ismember({fnList.name},{'.','..'}));
    fn = {fnList.name}';
    ffn = fullfile(fd_ct, fn{1});
    dcmInfo = dicominfo(ffn);

    ffn = fullfile(fd_mat, [MRN, '_CTinfo.mat']);
    save(ffn, 'dcmInfo')

    %% images
    [MM, SOPI_UID, xx, yy, zz, dateCreated, ipp, ps] = fun_readCTImage(fd_ct, fn);
%     machineName = dcmInfo.StationName;
    CT.MM = MM;
    CT.xx = xx;
    CT.yy = yy;
    CT.zz = zz;
    CT.dateCreated = num2str(dateCreated);
%     CT.machineName = machineName;
    CT.dcmInfo = dcmInfo;

    % save
    ffn = fullfile(fd_mat, [MRN, '_initialCT.mat']);
    save(ffn, 'CT')

    ffn = fullfile(fd_mat, [MRN, '_CTxyz.mat']);
    CTxx = xx;
    CTyy = yy;
    CTzz = zz;
    save(ffn, 'CTxx', 'CTyy', 'CTzz');