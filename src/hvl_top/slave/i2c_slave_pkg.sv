`ifndef I2C_SLAVE_PKG_INCLUDED_
`define I2C_SLAVE_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: i2c_slave_pkg
//  Includes all the files related to i2c_slave
//--------------------------------------------------------------------------------------------
package i2c_slave_pkg;

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
  `include "i2c_slave_tx.sv"
  // `include "i2c_slave_spi_seq_item_converter.sv"
  `include "i2c_slave_agent_config.sv"
  `include "i2c_slave_sequencer.sv"
  // `include "i2c_slave_sequence.sv"
  `include "i2c_slave_driver_proxy.sv"
  `include "i2c_slave_monitor_proxy.sv"
  `include "i2c_slave_coverage.sv"
  `include "i2c_slave_agent.sv"
  
endpackage : i2c_slave_pkg

`endif
