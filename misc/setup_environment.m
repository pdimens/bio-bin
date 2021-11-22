function setup_environment()
  disp("Downloading and decompressing course materials")
  websave("MAE101.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE101/matlabDeploy/MAE101.zip");
  unzip("MAE101.zip");
  addpath(genpath("MAE101"));
  savepath;
  delete MAE101.zip
  disp("Downloading and decompressing simulator")
  websave("simulator.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE100/Simulator.zip");
  unzip("Simulator.zip");
  addpath(genpath("Simulator"));
  savepath; 
  delete simulator.zip
  disp("Installing Robot Simulator Toolbox")
  matlab.addons.toolbox.installToolbox("Simulator/CreateRobotSimulator.mltbx");
  delete setup_environment.m
end
