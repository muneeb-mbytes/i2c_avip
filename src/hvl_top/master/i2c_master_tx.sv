`ifndef I2C_MASTER_TX_INCLUDED_
`define I2C_MASTER_TX_INCLUDED_

  typedef enum {ADDRESS_7BIT=7, ADDRESS_10BIT=10} slave_address_e;

//--------------------------------------------------------------------------------------------
// Class: i2c_master_tx
// <Description_here>
//--------------------------------------------------------------------------------------------

class i2c_master_tx extends uvm_sequence_item;
  `uvm_object_utils(i2c_master_tx)

  rand bit [9:0]slave_address;
  rand bit rd_wr;
  bit ack;
  rand bit [7:0]write_data;
  rand slave_address sl_addr_mode;
 
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_tx");
  extern function void do_print(uvm_printer printer);

  constraint w_data{ write_data == 8'b0000_0000; }
  constraint s_addr{
                    if(s1_addr_mode == ADDRESS_7BIT)  { slave_address == 7'b100_0000;}
                    if(sl_addr_mode == ADDRESS_10BIT) { slave_address == 10'b00_0000_0001;}
  }
  constraint slave_address_mode_c {sl_addr_mode == ADDRESS_7BIT;}
  constraint read_write{rd_wr == 1'b0;}
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

function void master_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field("RD_WR", this.rd_wr, 1, UVM_BIN);
  printer.print_field("SLAVE_ADDRESS", this.slave_address, 7, UVM_BIN);
  printer.print_field("WRITE_DATA", this.write_data, 8, UVM_BIN);
endfunction    
`endif

