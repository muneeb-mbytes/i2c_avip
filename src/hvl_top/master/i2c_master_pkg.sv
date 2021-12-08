`ifndef I2C_MASTER_PKG_INCLUDED_
`define I2C_MASTER_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: master_pkg
//  Includes all the files related to SPI master
//--------------------------------------------------------------------------------------------
package i2c_master_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
 
  // Import spi_globals_pkg 
  import i2c_globals_pkg::*;

  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "i2c_master_agent_config.sv"
  `include "i2c_master_tx.sv"
  `include "i2c_master_seq_item_converter.sv"
  `include "i2c_master_cfg_converter.sv"
  `include "i2c_master_sequencer.sv"
  `include "i2c_master_driver_proxy.sv"
  `include "i2c_master_monitor_proxy.sv"
  `include "i2c_master_coverage.sv"
  `include "i2c_master_agent.sv"
  
endpackage : i2c_master_pkg

`endif
