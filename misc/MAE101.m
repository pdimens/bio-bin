function setup_environment()
  disp("Downloading and decompressing course materials")
  websave(".MAE101.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE101/matlabDeploy/MAE101.zip");
  unzip(".MAE101.zip", ".MAE101");
  %addpath(genpath("MAE101"));
  %savepath;
  delete .MAE101.zip
  disp("Downloading and decompressing simulator")
  websave(".Simulator.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE100/Simulator.zip");
  unzip(".Simulator.zip", "Simulator");
  addpath(genpath("Simulator"));
  savepath; 
  delete .Simulator.zip
  disp("Installing Robot Simulator Toolbox")
  matlab.addons.toolbox.installToolbox("Simulator/CreateRobotSimulator.mltbx");
end
