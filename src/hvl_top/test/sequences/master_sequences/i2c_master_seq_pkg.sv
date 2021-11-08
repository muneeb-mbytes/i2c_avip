`ifndef I2C_MASTER_SEQ_PKG
`define I2C_MASTER_SEQ_PKG

//-----------------------------------------------------------------------------------------
// Package: i2c_master_seq_pkg
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
package i2c_master_seq_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import i2c_master_pkg::*;
  
  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  
  `include "i2c_master_sequences.sv"
endpackage : i2c_master_seq_pkg
`endif
