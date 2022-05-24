% Main script for the project regarding the dancing digital twin
import org.opensim.modeling.*

text_trc_file = 'Pick the the trc file to be used.';
if ismac
    % The Mac file dialog does not show the prompt in the file dialog.
    waitfor(msgbox(text_trc_file,'In the upcoming file dialog'));
end
trc_file=uigetfile('*.trc',text_trc_file);


text_model_file = 'Pick the the model file to be used.';
if ismac
    waitfor(msgbox(text_model_file,'In the upcoming file dialog'));
end
[modelFile,modelFilePath] = uigetfile('*.osim',text_model_file);

model = Model(fullfile(modelFilePath, modelFile));
model.initSystem();

% Since the orientation of the coordinate system is different between
% motion capture and OpenSim, the y and z are swifted. The ney y coordinate also needs a
% negative sign since the software are left- and righthanded.
correct_trc = modify_trc(trc_file);

% Stop here!
%% Continue when the first column is int and change the trc file in the IK setup xml file

% Scaling of the OpenSim model to obtain the dancers anthropometry
text_setup_scale = 'Pick the a generic setup file to for this subject/model as a basis for changes.';
if ismac
    waitfor(msgbox(text_setup_scale,'In the upcoming file dialog'));
end
genericSetupForScale = uigetfile('*.xml',text_setup_scale);

scaled_model = scale_func(genericSetupForScale, correct_trc);


% IK and motion file is stored in a new folder with current date and time 
mot_file = IK_func(scaled_model);