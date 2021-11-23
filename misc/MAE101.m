function MAE101(activity)
  if not(isfolder('.MAE101'))
    disp("Downloading Course Materials")
    websave(".MAE101.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE101/matlabDeploy/MAE101.zip");
    disp("Decompressing course materials")
    unzip(".MAE101.zip", ".MAE101.tmp");
    delete .MAE101.zip ;
    movefile .MAE101.tmp/MAE101 .MAE101 ;
  end
  if not(isfolder('Simulator'))
    disp("Downloading and decompressing simulator")
    websave(".Simulator.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE100/simulator.zip");
    unzip(".Simulator.zip", ".Simulator");
    movefile .Simulator/Simulator Simulator
    rmdir .Simulator s
    addpath(genpath("Simulator"));
    savepath; 
    delete .Simulator.zip
    disp("Installing Robot Simulator Toolbox")
    matlab.addons.toolbox.installToolbox("Simulator/CreateRobotSimulator.mltbx");
  end
  delete MAE101.asv ;
  if activity == "Activity 1"
     if not(isfolder('Exercise 1'))
        movefile .MAE101/'Exercise 1' 'Exercise 1' ;
        addpath(genpath('Exercise 1')) ;
        savepath ;
     else
        disp("Exercise 1 is already present in the working directory")
     end
  elseif activity == "Activity 2"
  if activity == "Activity 2"
     if not(isfolder('Exercise 2'))
        movefile .MAE101/'Exercise 2' 'Exercise 2' ;
        addpath(genpath('Exercise 2')) ;
        savepath ;
     else
        disp("Exercise 2 is already present in the working directory")
     end
  end
end
