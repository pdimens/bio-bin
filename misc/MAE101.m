function setup_environment(x)
  if x == "Activity 1"
    disp("Downloading and decompressing course materials")
    websave(".MAE101.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE101/matlabDeploy/MAE101.zip");
    unzip(".MAE101.zip", ".MAE101");
    %addpath(genpath("MAE101"));
    %savepath;
    delete .MAE101.zip ;
    movefile '.MAE101/Exercise 1/' 'Exercise 1' ;
    addpath(genpath('Exercise 1')) ;
    savepath ;
    disp("Downloading and decompressing simulator")
    websave(".Simulator.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE100/Simulator.zip");
    unzip(".Simulator.zip", "Simulator");
    addpath(genpath("Simulator"));
    savepath; 
    delete .Simulator.zip
    disp("Installing Robot Simulator Toolbox")
    matlab.addons.toolbox.installToolbox("Simulator/CreateRobotSimulator.mltbx");
  elseif x == "Activity 2"
    movefile '.MAE101/Exercise 2/' 'Exercise 2' ;
    addpath(genpath('Exercise 2')) ;
    savepath ;
  end
end
