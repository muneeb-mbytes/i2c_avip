`ifndef I2C_MASTER_TX_INCLUDED_
`define I2C_MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_tx
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_tx extends uvm_sequence_item;
  `uvm_object_utils(i2c_master_tx)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_tx");

endclass : i2c_master_tx

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_tx
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_master_tx::new(string name = "i2c_master_tx");

  super.new(name);
endfunction : new

`endif

