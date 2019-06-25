function [] = correlationMatrixLabeling(stats, plotTitle, cLabel, cAxis, color)
% Plots the correlation matrix with hemisphere labeling
figure;
%f=figure;
%f.OuterPosition = f.OuterPosition+[0 2 0 0];
imagesc(stats);
n=length(stats);
set(gca, 'XTick',1:n);
set(gca, 'YTick',1:n);
title(['\fontsize{20}',plotTitle]);
colormap(color);
c = colorbar;
c.Label.String = cLabel;
c.Label.FontSize = 20; %Changes the font size of the colorbar's label
caxis(cAxis);

%Hemisphere labels on x-axis
ax=gca; %access axes properties
ax.FontSize=20; %Changes font size of the sensor(?) numbers
ax.FontWeight='bold';
axPos=ax.Position;
ax.Position = axPos + [0 0.1 0 -0.1];
ax1 = axes('position', (axPos .* [1.5 1 0.43 1e-3]) + [0 0 0 0], 'color', 'none', 'linewidth', 2);
ax1.XLim = [0 1];
ax1.XTick=[0 1];
ax1.XTickLabel={};
ax2 = axes('position', (axPos .* [1.5 1 0.43 1e-3]) + [0 0 0 0], 'color', 'none', 'linewidth', 2);
ax2.XLim = [0 1];
ax2.TickDir = 'out';
ax2.XTick=[0.5];
ax2.XTickLabel={'Right Hemisphere'};
ax2.FontSize=20; %Changes the font size of the hemispheres
ax1.TickLength=[0.05 0.025];
ax2.TickLength=[0.05 0.025];

ax3 = axes('position', (axPos .* [4.5 1 0.44 1e-3]) + [0 0 0 0], 'color', 'none', 'linewidth', 2);
ax3.XLim = [0 1];
ax3.XTick=[0 1];
ax3.XTickLabel={};
ax4 = axes('position', (axPos .* [4.5 1 0.44 1e-3]) + [0 0 0 0], 'color', 'none', 'linewidth', 2);
ax4.XLim = [0 1];
ax4.TickDir = 'out';
ax4.XTick=[0.5];
ax4.XTickLabel={'Left Hemisphere'};
ax4.FontSize=20; %Changes the font size of the hemispheres
ax3.TickLength=[0.05 0.025];
ax4.TickLength=[0.05 0.025];

%Hemisphere labels on y-axis
ay=ax; %access axes properties
ayPos=ay.Position;
ay.Position = ayPos + [0.035 0 0 0];
ay1 = axes('position', (ayPos .* [0.65 1.05 1e-3 0.45]) + [0 0 0 0], 'color', 'none', 'linewidth', 2);
ay1.YLim = [0 1];
ay1.YTick=[0 1];
ay1.YTickLabel={};
ay2 = axes('position', (ayPos .* [0.65 1.05 1e-3 0.45]) + [0 0 0 0], 'color', 'none', 'linewidth', 2);
ay2.YLim = [0 1];
ay2.TickDir = 'out';
ay2.YTick=[0.5];
ay2.YTickLabel={'Left Hemisphere'};
ay2.FontSize=20; %Changes the font size of the hemispheres
ay2.YTickLabelRotation=90;
ay1.TickLength=[0.05 0.025];
ay2.TickLength=[0.05 0.025];

ay3 = axes('position', (ayPos .* [0.65 2.78 1e-3 0.45]) + [0 0 0 0], 'color', 'none', 'linewidth', 2);
ay3.YLim = [0 1];
ay3.YTick=[0 1];
ay3.YTickLabel={};
ay4 = axes('position', (ayPos .* [0.65 2.78 1e-3 0.45]) + [0 0 0 0], 'color', 'none', 'linewidth', 2);
ay4.YLim = [0 1];
ay4.TickDir = 'out';
ay4.YTick=[0.5];
ay4.YTickLabel={'Right Hemisphere'};
ay4.FontSize=20; %Changes the font size of the hemispheres
ay4.YTickLabelRotation=90;
ay3.TickLength=[0.05 0.025];
ay4.TickLength=[0.05 0.025];
end

