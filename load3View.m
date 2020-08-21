function load3View(CT, hA, hPlotObj)

hI = hPlotObj.I(1:3);
hXHair = hPlotObj.XHair(1:3);

MM = CT.MM;
xx = CT.xx;
yy = CT.yy;
zz = CT.zz;

[M, N, P] = size(MM);
iM = round(M/2);
iN = round(N/2);
iP = round(P/2);

x0 = xx(1);
y0 = yy(1);
z0 = zz(1);

dx = xx(2) - (1);
dy = yy(2) - yy(1);
dz = zz(1) - zz(2);

%% Axial
IA = MM(:,:,iP);

hIA = hI(1);
hIA.CData = IA;
hIA.XData = xx;
hIA.YData = yy;

hXHair(1).xLine.Position = [xx(iN) yy(1)
                                       xx(iN) yy(end)];
hXHair(1).yLine.Position = [xx(1) yy(iM)
                                       xx(end) yy(iM)];

hAA =hA(1);
hAA.CLim = [min(IA(:)) max(IA(:))];
hAA.XColor = 'r';
hAA.YColor = 'g';

axis(hAA, 'tight', 'equal')
hAA.Visible = 'on';

%% Sagital
IMP = squeeze(MM(:,iN, :));
IS = rot90(IMP);
% data.image.SagitalView.iN = iN;

hIS = hI(2);
hIS.CData = IS;

hIS.XData = yy;
hIS.YData = flip(zz);

hXHair(2).zLine.Position = [yy(1) zz(iP)
                                      yy(end) zz(iP)];
hXHair(2).yLine.Position = [yy(iM) zz(1)
                                      yy(iM) zz(end)];
                
hAS = hA(2);
hAS.CLim = [min(IS(:)) max(IS(:))];
hAS.XColor = 'g';
hAS.YColor = 'b';
hAS.YDir = 'normal';
hAS.Visible = 'on';

axis(hAS, 'tight', 'equal')

%% Coronal
INP = squeeze(MM(iM, :, :));
IC =rot90(INP);
% data.image.CoronalView.iM = iM;

hIC = hI(3);
hIC.CData = IC;
hIC.XData = xx;
hIC.YData = flip(zz);

hXHair(3).zLine.Position = [xx(1) zz(iP)
                                       xx(end) zz(iP)];
hXHair(3).xLine.Position = [xx(iN) zz(1)
                                     xx(iN) zz(end)];
% 
hAC = hA(3);
hAC.CLim = [min(IC(:)) max(IC(:))];
hAC.XColor = 'r';
hAC.YColor = 'b';
hAC.YDir = 'normal';
hAC.Visible = 'on';
axis(hAC, 'tight', 'equal')