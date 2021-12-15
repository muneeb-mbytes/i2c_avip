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
  read_write_e read_write;

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
  // The no_of_wr_data_elements should be assignes in vseqence and pass it to both slave and
  // slave sequences for this to work
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_slave_tx");
  extern function void do_print(uvm_printer printer);

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

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void i2c_slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field($sformatf("slave_address"),this.slave_address,$bits(slave_address),UVM_HEX);
  printer.print_field($sformatf("register_address"),this.register_address,8,UVM_HEX);
  printer.print_string($sformatf("read_write"),read_write.name());
  
  //foreach(wr_data[i]) begin
  //  printer.print_field($sformatf("wr_data[%0d]",i),this.wr_data[i],8,UVM_HEX);
  //end

  printer.print_field($sformatf("slave_addr_ack"),this.slave_addr_ack,1,UVM_BIN);
  printer.print_field($sformatf("reg_addr_ack"),this.reg_addr_ack,1,UVM_BIN);
  //foreach(wr_data_ack[i]) begin
  //  printer.print_field($sformatf("wr_data_ack[%0d]",i),this.wr_data_ack[i],1,UVM_HEX);
  //end

endfunction : do_print
`endif

