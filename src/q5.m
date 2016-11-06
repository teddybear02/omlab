%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%


%% Annotate first intersaccadic interval (ISI)

clear
dataPlotter(21);  hold on
set(gcf, 'Name','Question 5')
title('Saccadic Tests: \itTaking a Closer Look')
xlim([3.4 5]);  ylim([-15 20])

% Annotate target
plot([4 5], [0 0], 'r:')
annotation('doublearrow', [0.4223 0.5667], [0.32 0.32],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
annotation('textbox', [0.488 0.293 0.022 0.0485],...
           'String','T',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle',...
           'FontWeight','bold',...
           'FitBoxToText','off',...
           'EdgeColor','none',...
           'BackgroundColor',[1 1 1]);

% Annotate right eye...
co = get(groot, 'DefaultAxesColorOrder');  coR = co(1,:);
plot([3.4 5], -2.261*[1 1], ':', 'Color',coR)
plot([4.485 5], 7.89*[1 1], ':', 'Color',coR)

% ... Annotate ISI
annotation('doublearrow', [0.5190 0.63], [0.385 0.385],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
annotation('textbox', [0.572 0.368 0.03 0.0343],...
           'String','ISI',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle',...
           'FontWeight','bold',...
           'FitBoxToText','off',...
           'EdgeColor','none',...
           'BackgroundColor',[1 1 1])

% ... Annotate t2
annotation('doublearrow', [0.5683 0.63], [0.423 0.423],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
text      (4.371, -0.75, 't2',...
           'FontWeight','bold',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle')

% ... Annotate a1
annotation('doublearrow', [0.3 0.3], [0.405 0.533],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
annotation('textbox', [0.29 0.465 0.0209 0.03],...
           'String','a1',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle',...
           'FontWeight','bold',...
           'FitBoxToText','off',...
           'EdgeColor','none',...
           'BackgroundColor',[1 1 1])

% ... Annotate a2
annotation('doublearrow', [0.8 0.8], [0.405 0.644],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
annotation('textbox', [0.79 0.5 0.0209 0.03],...
           'String','a2',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle',...
           'FontWeight','bold',...
           'FitBoxToText','off',...
           'EdgeColor','none',...
           'BackgroundColor',[1 1 1])


%% Find target 'saccades'

spikeRises = [];
spikeFalls = [];
index = 1;

spikeRise = NaN;

while ~isempty(spikeRise)
  
  spikeRise = (index-1) + find(st(index:end) > 1, 1);
  spikeRises = [spikeRises spikeRise];
  
  spikeFall = (spikeRise-2) + find(st(spikeRise:end) < 1, 1);
  spikeFalls = [spikeFalls spikeFall];
  
  index = spikeFall + 1;
  
end

%% Compute target delays

starts = t(spikeRises);
delays = t(spikeFalls) - starts;

% Print results
disp([starts delays])
