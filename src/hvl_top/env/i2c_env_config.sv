`ifndef I2C_ENV_CONFIG_INCLUDED_
`define I2C_ENV_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_env_config
// This class is used as configuration class for environment and its components
//--------------------------------------------------------------------------------------------
class i2c_env_config extends uvm_object;
  `uvm_object_utils(i2c_env_config)

  // Variable: has_scoreboard
  // Enables the scoreboard. Default value is 1
  bit has_scoreboard = 1;
  
  // Variable: has_virtual_sqr
  // Enables the virtual sequencer. Default value is 1
  bit has_virtual_sequencer = 1;
  
  // Variable: no_of_slaves
  // Number of masters connected to the I2C interface
  int no_of_masters;
  
  // Variable: no_of_slaves
  // Number of slaves connected to the I2C interface
  int no_of_slaves;
  
  // Variable: i2c_master_agent_cfg_h
  // Dynamic array of master agnet configuration handles
  i2c_master_agent_config i2c_master_agent_cfg_h[];
  
  // Variable: i2c_slave_agent_cfg_h
  // Dynamic array of slave agnet configuration handles
  i2c_slave_agent_config i2c_slave_agent_cfg_h[];



  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_env_config");

endclass : i2c_env_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_env_config
//--------------------------------------------------------------------------------------------
function i2c_env_config::new(string name = "i2c_env_config");
  super.new(name);
endfunction : new

`endif

