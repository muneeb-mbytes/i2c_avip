`ifndef I2C_MASTER_SEQUENCE_INCLUDED_
`define I2C_MASTER_SEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_sequence
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_sequence extends uvm_component;
  `uvm_component_utils(i2c_master_sequence)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_sequence", uvm_component parent = null);

endclass : i2c_master_sequence

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_sequence
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_master_sequence::new(string name = "i2c_master_sequence",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new


`endif

