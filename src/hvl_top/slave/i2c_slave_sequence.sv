`ifndef I2C_SLAVE_SEQUENCE_INCLUDED_
`define I2C_SLAVE_SEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_slave_sequence
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_slave_sequence extends uvm_object;
  `uvm_object_utils(i2c_slave_sequence)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_slave_sequence");
endclass : i2c_slave_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_slave_sequence
//--------------------------------------------------------------------------------------------
function i2c_slave_sequence::new(string name = "i2c_slave_sequence");
  super.new(name);
endfunction : new

`endif

