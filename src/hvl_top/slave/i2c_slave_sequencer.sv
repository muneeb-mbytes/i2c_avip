`ifndef I2C_SLAVE_SEQUENCER_INCLUDED_
`define I2C_SLAVE_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_slave_sequencer
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_slave_sequencer extends uvm_component;
  `uvm_component_utils(i2c_slave_sequencer)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_slave_sequencer", uvm_component parent = null);

endclass : i2c_slave_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_slave_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_slave_sequencer::new(string name = "i2c_slave_sequencer",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

`endif

