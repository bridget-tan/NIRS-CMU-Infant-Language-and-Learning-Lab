%Adapted from analysis code written by Frank Fishburn

%% Load raw data
raw = nirs.io.loadDirectory('.',{'Group'});

%% Extract probe
probe = raw(1).probe;

%% Swap X and Y axis for probe
tmpX = probe.optodes.X;
probe.optodes.X = probe.optodes.Y;
probe.optodes.Y = tmpX;

%% Put fixed probe into each data object
for i=1:length(raw)
    raw(i).probe = probe;
end

%% Preprocessing
% Create preprocessing job
job = nirs.modules.OpticalDensity(); % Convert from raw intensity to optical density
job = nirs.modules.TDDR(job); % Perform motion correction
job = nirs.modules.Resample(job); % Resample from 20 Hz down to 1 Hz
    job.Fs = 1;
    job.antialias = true;
job = eeg.modules.BandPassFilter(job); % Use high-pass filter to remove drift in signal
    job.lowpass = [];
    job.highpass = .01;
    job.do_downsample = false;
job = nirs.modules.TrimBaseline(job); % Remove excess time at beginning and end
    job.preBaseline = 0;
    job.postBaseline = 0;
job = nirs.modules.BeerLambertLaw(job); % Convert to hemoglobin concentration
job = nirs.modules.KeepTypes(job); % Remove deoxy-hemoglobin
    job.types = {'hbo'}

% Run the preprocessing job  
hb = job.run(raw);

%% 1st-level connectivity
% Create the subject-level connectivity job
job = nirs.modules.Connectivity();
    job.corrfcn = @(data) nirs.sFC.ar_corr(data,'32xFs',true);

% Run connectivity job
SubjStats = job.run(hb);

%% 2nd-level statistical analysis
% Create the group-level connectivity job
job = nirs.modules.MixedEffectsConnectivity();
%job.formula='beta ~ -1 + Group';

% Run the job
GroupStats = job.run(SubjStats);

%group stats 
GroupStats.table()

%subject stats
for i=1:length(raw)
    SubjStats(i).table();
end 

%% correlation matrix
stats = GroupStats.R(:,:,1);
plotTitle = 'Prefrontal Cortex Resting State Connectivity';
cLabel = 'R-values';
cAxis = [0 1];
color = 'jet';
correlationMatrixLabeling(stats, plotTitle, cLabel, cAxis, color);
