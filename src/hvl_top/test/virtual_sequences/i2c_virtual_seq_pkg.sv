`ifndef SPI_VIRTUAL_SEQ_PKG_INCLUDED_
`define SPI_VIRTUAL_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: i2c_virtual_seq_pkg
//  Includes all the files related to i2c virtual sequences
//--------------------------------------------------------------------------------------------
package i2c_virtual_seq_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import i2c_master_pkg::*;
  import i2c_slave_pkg::*;
  import i2c_master_seq_pkg::*;
  import i2c_slave_seq_pkg::*;
  import i2c_env_pkg::*;


  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
   `include "i2c_virtual_seq_base.sv"
endpackage : i2c_virtual_seq_pkg

`endif
