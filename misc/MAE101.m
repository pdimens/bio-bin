function MAE101(exercise)
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
  if not(isfolder('Helper Functions'))
    copyfile .MAE101/'Helper Functions'/ 'Helper Functions'
    addpath(genpath('Helper Functions'));
    savepath; 
  end
  if not(isfolder('Maps'))
    copyfile .MAE101/'Maps' 'Maps'
    addpath(genpath("Maps"));
    savepath; 
  end
  if not(isfolder('Project'))
    copyfile .MAE101/'Project' 'Project'
    addpath(genpath("Project"));
    savepath; 
  end
  if isfile("MAE101.asv")
      delete MAE101.asv ;
  end
  exer = char(exercise) ;
  if not(isfolder(exer))
    copyfile(append('.MAE101/', exer), exer) ;
    addpath(genpath(exer)) ;
    savepath ;
  end
end
