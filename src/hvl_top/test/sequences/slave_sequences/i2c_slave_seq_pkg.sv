
`ifndef I2C_SLAVE_SEQ_PKG
`define I2C_SLAVE_SEQ_PKG

//-----------------------------------------------------------------------------------------
// Package: i2c_slave_seq_pkg
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
package i2c_slave_seq_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import i2c_slave_pkg::*;
  
  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  
  `include "i2c_slave_sequences.sv"
endpackage : i2c_slave_seq_pkg
`endif