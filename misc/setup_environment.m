function setup_environment()
  websave("MAE101.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE101/matlabDeploy/MAE101.zip");
	unzip("MAE101.zip");
	addpath(genpath("MAE101"));
	savepath;
	websave("simulator.zip","https://ecornell.s3.amazonaws.com/content/MAE/MAE100/simulator.zip");
  unzip("simulator.zip");
	addpath(genpath("simulator"));
	savepath;
	matlab.addons.toolbox.installToolbox("Simulator/CreateRobotSimulator.mltbx");
end
