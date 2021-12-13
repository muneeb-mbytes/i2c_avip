`ifndef I2C_SLAVE_TX_INCLUDED_
`define I2C_SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_slave_tx
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_slave_tx extends uvm_sequence_item;
  `uvm_object_utils(i2c_slave_tx)

  // Received fields 
  bit [SLAVE_ADDRESS_WIDTH-1:0]slave_address;
  bit [REGISTER_ADDRESS_WIDTH-1:0]register_address;
  bit [DATA_WIDTH-1:0]wr_data[];

  // Receiving data fields
  // This is derived from the config slave_address value
  bit slave_addr_ack;

  rand bit reg_addr_ack;
  rand bit [MAXIMUM_BYTES-1:0] wr_data_ack;
  rand bit [DATA_WIDTH-1:0] rd_data[];

  //-------------------------------------------------------
  // Constraints
  //-------------------------------------------------------
  constraint reg_addr_c { soft reg_addr_ack == POS_ACK; } 
  constraint wr_data_ack_c {soft $countones(wr_data_ack) == 0;}
  constraint rd_data_c { soft rd_data.size() == 4;}

  // TODO(mshariff): For randomily selecting the NEG_ACK for write_data elements 
  // constraint wr_data_ack_c2 {$countones(wr_data_ack) == 1; 
  //                            wr_data_ack == 2 ** (no_of_wr_data_elements);  }
  // The no_of_wr_data_elements should be assignes in vseqence and pass it to both master and
  // slave sequences for this to work
  
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

