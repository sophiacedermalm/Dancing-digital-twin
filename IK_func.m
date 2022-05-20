function [mot_file] = IK_func(model)
% Function for Ik in OpenSim where the motion is estimated

import org.opensim.modeling.*


% Go to the folder in the subject's folder where .trc files are
text_trc_data_folder = 'Select the folder that contains the marker data files in .trc format.';
if ismac
    waitfor(msgbox(text_trc_data_folder,'In the upcoming file dialog'));
end
trc_data_folder = uigetdir('testData', text_trc_data_folder);


% Get and operate on the files
% Choose a generic setup file to work from
text_setup_IK = 'Pick the a generic setup file to for this subject/model as a basis for changes.';
if ismac
    waitfor(msgbox(text_setup_IK,'In the upcoming file dialog'));
end
[genericSetupForIK,genericSetupPath] = uigetfile('*.xml', text_setup_IK);

ikTool = InverseKinematicsTool([genericSetupPath genericSetupForIK]);


% Tell Tool to use the loaded model
ikTool.setModel(model);


    
% Get the name of the file for this trial
%markerFile = trialsForIK(trial).name;
text_trc_marker_file = 'Pick the the trc file to be used.';
    
if ismac
    waitfor(msgbox(text_trc_marker_file,'In the upcoming file dialog'));
end

markerFile=uigetfile('*.trc', text_trc_marker_file);
    
% Create name of trial from .trc file name
name = regexprep(markerFile,'.trc','');
fullpath = fullfile(trc_data_folder, markerFile);
    
% Get trc data to determine time range
markerData = MarkerData(fullpath);
    
% Get initial and intial time 
initial_time = markerData.getStartFrameTime();
final_time = markerData.getLastFrameTime();
    
    % Setup the ikTool for this trial
    ikTool.setName(name);
    ikTool.setMarkerDataFileName(fullpath);
    ikTool.setStartTime(initial_time);
    ikTool.setEndTime(final_time);


    currDate = strrep(datestr(datetime), ':', '_');
    %results_folder = mkdir(currDate);
    mkdir(currDate);
    ikTool.setOutputMotionFileName(fullfile(currDate, [name '_ik.mot']));
    
    % Save the settings in a setup file
    %outfile = ['Setup_IK_' name '.xml'];
    %ikTool.print(fullfile(genericSetupPath, outfile));
    
    %fprintf(['Performing IK on cycle # ' num2str(trial) '\n']);
    % Run IK
    ikTool.run();
% C=clock;

%end
%currDate = strrep(datestr(datetime), ':', '_');
%mkdir['Result' currDate]
mot_file = ikTool.getOutputMotionFileName();

end