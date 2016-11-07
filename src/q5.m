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

clear;  loadTrial(21)

tframes = 0:3:t(end-1);
NaNs = NaN(size(tframes));   T  = NaNs;
a1 = NaNs;  a2 = NaNs;  t2 = NaNs;  ISI = NaNs;

dataPlotter(21);  ylim([-15 20])

for i = 1:length(tframes)
  fprintf('Frame #%i:\n', i)
  tframe = tframes(i);  xlim([0 3] + tframe)
  ii = find(t >= tframe & t < tframe+3);
  tt = t(ii);  LH = lh(ii);  RH = rh(ii);  ST = st(ii);
  ii = ii - ii(1);
  
  % Find T
  iT0 = find(abs(ST) > 1, 1);
  iT1 = iT0 + find(abs(st(iT0:ii(end))-st(iT0)) > 1, 1);
  T0 = tt(iT0);  T1 = tt(iT1);  T(i) = T1 - T0;
  fprintf('  T  = %.2f\n', T(i))
  
  try
    % Find a1 and a2
    disp('  Enter amplitudes graphically...')
    fprintf('    ->  a1  = ')
    p = ginput(1);  a1(i) = p(2);  fprintf('%.2f\n', a1(i))
    fprintf('    ->  a2  = ')
    p = ginput(1);  a2(i) = p(2);  fprintf('%.2f\n', a2(i))
    
    % Find t2 and ISI
    disp('  Enter ISI endpoints graphically...')
    p = ginput(2);  [ISI0,ISI1] = sort(p(:,1));
    t2(i)  = ISI1-T1;    fprintf('    ->  t2  = %.2f',  t2(i))
    ISI(i) = ISI1-ISI0;  fprintf('    ->  ISI = %.2f', ISI(i))
  catch
    T(i) = NaN;   ... Invalidate this frame
    a1(i) = NaN;  a2(i) = NaN;  t2(i) = NaN;  ISI(i) = NaN;
  end
end
disp('Completed parameter measurements!')

% Compute means for each target delay
table1 = table(T, a1, a2, t2, ISI);    disp(table1)
