# Dancing-digital-twin
Expanding the digital twin that ISB research group at Linköping University develop. Expanding with biomechanical modelling of the human body by a dance sequence. Later acquired muscle forces will be analysed.

The pipeline is developed in OpenSim. It includes two OSIM-files with the model in OpenSim with marker set for both motion capture labs Vicon and OptiTrack. It also includes setup XML-files for scaling and inverse kinematics which contains all the information needed in order to run the tools in OpenSim. A motion capture file wich is converted to a TRC-file with Mokka is also included but only for the marker set for OptiTrack.


**To run this project:**
-  Start with finding out the orientation of the coordinate system for both OpenSim and motion capture data. If they are the same, the first section in the    MATLAB script main_with_functions.m can be ignored. If they are not the same, find out the difference and change in the MATLAB script modify_trc.m and      then run the first section of main_with_functions.m
-  Next, check so that the desired trc file is set in the scale_setup.xml file, if not change. 
-  Run the next section in the MATLAB script main_with_functions.m

This can also be run through the OpenSim user interface. To do that, open the model and then scale with the scale_setup.xml file. Then, run the tool inverse kinematics with the IK_setup.xml and the result will contain the MOT file with joint angles. 
