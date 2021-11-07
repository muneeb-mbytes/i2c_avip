`ifndef I2C_ENV_PKG_INCLUDED_
`define I2C_ENV_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: i2c_env_pkg
// Includes all the files related to I2C i2c_env
//--------------------------------------------------------------------------------------------
package i2c_env_pkg;
  
  // Import uvm package
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  // Importing the required packages
  import i2c_globals_pkg::*;
  import i2c_master_pkg::*;
  import i2c_slave_pkg::*;

  // Include all other files
  `include "i2c_env_config.sv"
  `include "i2c_virtual_sequencer.sv"

  // SCOREBOARD
  `include "i2c_scoreboard.sv"

  // Coverage 

  
  //Include env file
  `include "i2c_env.sv"

endpackage : i2c_env_pkg

`endif
