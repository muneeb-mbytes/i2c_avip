`ifndef I2C_MASTER_TX_INCLUDED_
`define I2C_MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_tx
// <Description_here>
//--------------------------------------------------------------------------------------------

class i2c_master_tx extends uvm_sequence_item;
  `uvm_object_utils(i2c_master_tx)

  rand bit [SLAVE_ADDRESS_WIDTH-1:0]slave_address;
  rand bit read_write;
  rand bit [7:0]reg_address;
  rand bit [7:0]data;
  rand slave_address_width_e sl_addr_mode;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_tx");
  extern function void do_print(uvm_printer printer);

  constraint w_data{ data == 8'b0000_0000; }
  constraint s_addr{
                    if(sl_addr_mode == 1'b0)  { slave_address == 7'b100_0000;}
                    if(sl_addr_mode == 1'b1) { slave_address == 10'b00_0000_0001;}
  }
  constraint slave_address_width_e {sl_addr_mode == 1'b0;}
  //constraint read_write{read_write == 1'b0;}
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

function void i2c_master_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field("RD_WR", this.read_write, 1, UVM_BIN);
  printer.print_field("SLAVE_ADDRESS", this.slave_address, 7, UVM_BIN);
  printer.print_field("data", this.data, 8, UVM_BIN);
endfunction    
`endif
