`ifndef I2C_MASTER_SEQUENCES_INCLUDED_
`define I2C_MASTER_SEQUENCES_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_sequences 
// creating i2c_master_sequences class extends from uvm_sequence
//--------------------------------------------------------------------------------------------

class i2c_master_sequences extends uvm_sequence #(i2c_master_tx);
  //factory registration
  `uvm_object_utils(i2c_master_sequences)
  
  //-------------------------------------------------------
  // Externally defined Function
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_sequences");
endclass : i2c_master_sequences

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function i2c_master_sequences::new(string name = "i2c_master_sequences");
  super.new(name);
endfunction : new

`endif
