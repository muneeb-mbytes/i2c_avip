`ifndef I2C_MASTER_BASE_SEQ_INCLUDED_
`define I2C_MASTER_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_base_seq
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_base_seq extends uvm_sequence #(i2c_master_tx);
  `uvm_object_utils(i2c_master_base_seq)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_base_seq");
endclass : i2c_master_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_base_seq
//--------------------------------------------------------------------------------------------
function i2c_master_base_seq::new(string name = "i2c_master_base_seq");
  super.new(name);
endfunction : new

`endif

