`ifndef I2C_VIRTUAL_SEQ_PKG_INCLUDED_
`define I2C_VIRTUAL_SEQ_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: Test
// Description:
// Includes all the files written to run the simulation
//--------------------------------------------------------------------------------------------
package i2c_virtual_seq_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import i2c_master_pkg::*;
  import i2c_slave_pkg::*;
  import i2c_master_seq_pkg::*;
  import i2c_slave_seq_pkg::*;
  import i2c_env_pkg::*;

 //including base_test for testing
 `include "i2c_virtual_base_seq.sv"

 `include "i2c_8b_virtual_seq.sv"
endpackage : i2c_virtual_seq_pkg

`endif
