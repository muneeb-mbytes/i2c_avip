<<<<<<< HEAD
`ifndef SPI_VIRTUAL_SEQ_PKG_INCLUDED_
`define SPI_VIRTUAL_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: i2c_virtual_seq_pkg
//  Includes all the files related to i2c virtual sequences
=======
`ifndef I2C_VIRTUAL_SEQ_PKG_INCLUDED_
`define I2C_VIRTUAL_SEQ_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
// Package: Test
// Description:
// Includes all the files written to run the simulation
>>>>>>> eb2c30b053f80320e7eccda8e8968ea496b86512
//--------------------------------------------------------------------------------------------
package i2c_virtual_seq_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
<<<<<<< HEAD
=======

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
>>>>>>> eb2c30b053f80320e7eccda8e8968ea496b86512
  import i2c_master_pkg::*;
  import i2c_slave_pkg::*;
  import i2c_master_seq_pkg::*;
  import i2c_slave_seq_pkg::*;
  import i2c_env_pkg::*;

<<<<<<< HEAD

  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
   `include "i2c_virtual_seq_base.sv"
=======
 //including base_test for testing
 `include "i2c_virtual_sequence.sv"

>>>>>>> eb2c30b053f80320e7eccda8e8968ea496b86512
endpackage : i2c_virtual_seq_pkg

`endif
