`ifndef I2C_MASTER_TX_INCLUDED_
`define I2C_MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_tx
// <Description_here>
//--------------------------------------------------------------------------------------------

class i2c_master_tx extends uvm_sequence_item;
  `uvm_object_utils(i2c_master_tx)

  rand bit read_write;
  bit [SLAVE_ADDRESS_WIDTH-1:0]slave_address;
  rand bit [REGISTER_ADDRESS_WIDTH-1:0]reg_address;
  rand bit [DATA_WIDTH-1:0]data[];
  bit ack;
  bit nack;
  
  //-------------------------------------------------------
  // Constraints for I2C
  //-------------------------------------------------------
  
 // constraint reg_addr{reg_address.size() > 0 ;
 //                    reg_address.size() < MAXIMUM_BITS/CHAR_LENGTH;}
 // 
 // constraint data{reg_address.size() > 0 ;
 //                    reg_address.size() < MAXIMUM_BITS/CHAR_LENGTH;}
 // 
 // constraint slave_address_width_e {slave_addr_mode == 1'b0;}
 // 
 // constraint slave_addr{
 //                       if(slave_addr_mode == 1'b0) 
 //                         {slave_address == 7'b101_0100;}
 //                       if(slave_addr_mode == 1'b1) 
 //                         {slave_address == 10'b10_1010_0101;}
 // }


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_tx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer); 
  extern function void do_print(uvm_printer printer);

endclass : i2c_master_tx

//--------------------------------------------------------------------------------------------
//  Construct: new
//  initializes the class object
//
//  Parameters:
//  name - i2c_master_tx
//--------------------------------------------------------------------------------------------
function i2c_master_tx::new(string name = "i2c_master_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// do_copy method
//--------------------------------------------------------------------------------------------

function void i2c_master_tx::do_copy (uvm_object rhs);
  i2c_master_tx rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);

  slave_address= rhs_.slave_address;
  reg_address = rhs_.reg_address;
  data = rhs_.data;

endfunction : do_copy


//--------------------------------------------------------------------------------------------
// do_compare method
//--------------------------------------------------------------------------------------------
function bit  i2c_master_tx::do_compare (uvm_object rhs,uvm_comparer comparer);
  i2c_master_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
  `uvm_fatal("FATAL_I2C_MASTER_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(rhs,comparer) &&
  slave_address== rhs_.slave_address &&
  reg_address == rhs_.reg_address &&
  data == rhs_.data;
endfunction : do_compare 
//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void i2c_master_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  foreach(reg_address[i]) begin
    printer.print_field($sformatf("reg_address[%0d]",i),this.reg_address
    [i],8,UVM_HEX);
  end
  foreach(data[i]) begin
    printer.print_field($sformatf("data[%0d]",i),this.data[i],8,UVM_HEX);
  end
  printer.print_field($sformatf("slave_address"),this.slave_address,$bits(slave_address),UVM_BIN);

endfunction : do_print

`endif
