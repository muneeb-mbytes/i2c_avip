`ifndef I2C_SLAVE_TX_INCLUDED_
`define I2C_SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_slave_tx
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_slave_tx extends uvm_sequence_item;
  `uvm_object_utils(i2c_slave_tx)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_slave_tx");

endclass : i2c_slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_slave_tx
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_slave_tx::new(string name = "i2c_slave_tx");

  super.new(name);
endfunction : new

`endif

