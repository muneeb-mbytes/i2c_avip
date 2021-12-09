`ifndef I2C_SLAVE_TX_INCLUDED_
`define I2C_SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_slave_tx
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_slave_tx extends uvm_sequence_item;
  `uvm_object_utils(i2c_slave_tx)

 // bit [SLAVE_ADDRESS_WIDTH-1:0]slave_address;
 // bit [REGISTER_ADDRESS_WIDTH-1:0]register_address;
 // bit [DATA_WIDTH-1:0]data[];
 // bit ack;
 // 
 // 
 // // Receiving data fields
 // bit slave_add_ack;
 // bit reg_add_ack;
 // bit wr_data_ack[$];
  
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

