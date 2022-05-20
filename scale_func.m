function [scaled_model] = scale_func(genericSetupForScale, correct_trc)
% Function for scaling the model in OpenSim to the subject anthropometry

import org.opensim.modeling.*

scaleTool = ScaleTool(genericSetupForScale);

scaleTool.setName(correct_trc); %Change trc in xml file

scaled_model = scaleTool.createModel(); 

scaleTool.run();

end