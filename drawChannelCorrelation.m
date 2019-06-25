function drawChannelCorrelation(refCh,rawData,plotTitle,cLabel,cAxis,color1,color2)
%% Draws channel-wise correlation on a brain mesh referencing a channel
% Adapted from nirs toolbox Probe1020 class
% Args:
%   refCh     - reference channel
%   rawData   - matrix of correlation data
%   plotTitle - figure title
%   cLabel    - colorbar label
%   cAxis     - colorbar axis limits
%   color1    - lower limit color
%   color2    - upper limit color
%
% Examples:
%

figure;

%% Load data
% Load the probe mapping data into the variable probe1020
load('probe1020.mat','probe1020');
rawData(isnan(rawData)) = 1; %replace NaNs with 1
data = rawData(refCh,:);

%% Set link variable
if(~isempty(probe1020.link))
    if isnumeric(probe1020.link.type)
        link = probe1020.link(probe1020.link.type==probe1020.link.type(1),1:2);
    else
        link = probe1020.link(strcmp(probe1020.link.type,probe1020.link.type(1)),1:2);
    end
else
    link=table;
end

%% Draw the brain model (aka mesh)
axis_handle = gca;
v='frontal';
mesh = probe1020.getmesh;
h = mesh.draw();
axis(axis_handle,'tight');
nirs.util.rotateview(get(h(1),'Parent'),v);

%% Draw the probes and channels
% Points from the probe
Pos(:,1)=probe1020.optodes_registered.X;
Pos(:,2)=probe1020.optodes_registered.Y;
Pos(:,3)=probe1020.optodes_registered.Z;

%hold(axis_handle,'on');

% Create shapes for 3D probe rendering
[x_sph,y_sph,z_sph] = sphere(50);
x_sph = 4*x_sph;
y_sph = 4*y_sph;
z_sph = 4*z_sph;

% Draw optodes
lstS=find(ismember(probe1020.optodes_registered.Type,'Source'));
lstD=find(ismember(probe1020.optodes_registered.Type,'Detector'));
src_coord = Pos(lstS,:);
det_coord = Pos(lstD,:);
for i=1:size(src_coord,1)
    surf(axis_handle, x_sph+src_coord(i,1), y_sph+src_coord(i,2), z_sph+src_coord(i,3) ,[],'FaceColor',[1 0 0],'EdgeAlpha',0);
end
for i=1:size(det_coord,1)
    surf(axis_handle, x_sph+det_coord(i,1), y_sph+det_coord(i,2), z_sph+det_coord(i,3) ,[],'FaceColor',[0 0 1],'EdgeAlpha',0);
end

%% Draw channels as ball and stick model
for i=1:height(link)
    % i is equivalent to the channel number
    if iscell(link.source(i))
        source = link.source{i};
        detector = link.detector{i};
    else
        source = link.source(i);
        detector = link.detector(i);
    end
    %draws each channel
    
    %Figure out how to customize this
    % arg 'flipColors'?
    chColor = [0 abs(data(i))/max(data) 1-abs(data(i))/max(data)]; %channel color
    if i==refCh
        chColor = [1 0 0];
    end
    caxis(cAxis);
    for j=1:length(source)
        s = source(j);
        d = detector(j);

        src = Pos(lstS(s),:);
        det = Pos(lstD(d),:);

        [x,y,z] = cylinder2P(2,100,src,det);
        sf = surf(x,y,z,[],'FaceColor',chColor,'EdgeAlpha',0,'FaceAlpha',1,'FaceLighting','none');
    end
end
% Set the colors and limits of the colormap
cdata = [cAxis(1) color1 cAxis(2) color2];
dlmwrite('pValue.cpt', cdata, ' ');
cptcmap('pValue', 'mapping', 'direct');
c = colorbar;
c.Label.String = cLabel;
c.Label.FontSize = 20;
caxis(cAxis);
title(['\fontsize{20}',plotTitle]);

axis(axis_handle,'equal');
end