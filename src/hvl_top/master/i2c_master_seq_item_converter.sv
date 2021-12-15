`ifndef I2C_MASTER_SEQ_ITEM_CONVERTER_INCLUDED_
`define I2C_MASTER_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// class : i2c_master_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class i2c_master_seq_item_converter extends uvm_object;
  
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_seq_item_converter");
  extern static function void from_class(input i2c_master_tx input_conv_h,
                                         output i2c_transfer_bits_s output_conv);

  extern static function void to_class(input i2c_transfer_bits_s input_conv_h,     
                                       output i2c_master_tx output_conv);
  //extern function void from_class_msb_first(input i2c_master_tx input_conv_h, 
  //                                           output i2c_transfer_bits_s output_conv);
  extern function void do_print(uvm_printer printer);

endclass : i2c_master_seq_item_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_seq_item_converter
//--------------------------------------------------------------------------------------------
function i2c_master_seq_item_converter::new(string name = "i2c_master_seq_item_converter");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------
function void i2c_master_seq_item_converter::from_class(input i2c_master_tx input_conv_h,
                                                        output i2c_transfer_bits_s output_conv);
  
  //converting of the slave address                                                      
  output_conv.slave_address = input_conv_h.slave_address;

  output_conv.read_write = read_write_e'(input_conv_h.read_write);
  
  //converting of the register address
  output_conv.register_address = input_conv_h.register_address;
  `uvm_info("DEBUG_MSHA", $sformatf("input_conv_h.register_address = %0x and output_conv.register_address = %0x", input_conv_h.register_address, output_conv.register_address ), UVM_NONE)

  output_conv.no_of_i2c_bits_transfer = input_conv_h.wr_data.size() * DATA_WIDTH;

  for(int i=0; i<input_conv_h.wr_data.size();i++) begin
   // MSHA: `uvm_info("master_seq_item_conv_class",
   // MSHA: $sformatf("wr_data = \n %p",output_conv.wr_data),UVM_LOW)
   // MSHA:// output_conv.wr_data = output_conv.wr_data << data_LENGTH;
   // MSHA: `uvm_info("master_seq_item_conv_class",
   // MSHA: $sformatf("After shift wr_data = \n %p",output_conv.wr_data),UVM_LOW)
   // MSHA: `uvm_info("master_seq_item_conv_class",
   // MSHA: $sformatf("After shift input_cov_h wr_data = \n %p",
   // MSHA: input_conv_h.wr_data[i]),UVM_LOW)

    output_conv.wr_data[i][DATA_WIDTH-1:0] = input_conv_h.wr_data[i];    

   // MSHA: `uvm_info("master_seq_item_conv_class",
   // MSHA: $sformatf("After shift input_cov_h wr_data = \n %p",
   // MSHA: input_conv_h.wr_data[i]),UVM_LOW)
   // MSHA: //output_conv.wr_data[i*8 +: 8]= input_conv_h.wr_data[i];    
   // MSHA: 
   // MSHA: `uvm_info("master_seq_item_conv_class",
   // MSHA: $sformatf("wr_data = \n %p",output_conv.wr_data),UVM_LOW)
  end

  // Be default the ACK should be 1
  // so that the slave ACK value can be stored
  output_conv.slave_addr_ack = 1;
  output_conv.reg_addr_ack = 1;
  output_conv.wr_data_ack= '1;

endfunction: from_class 


//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------
function void i2c_master_seq_item_converter::to_class(input i2c_transfer_bits_s input_conv_h,
                                                      output i2c_master_tx output_conv);
  output_conv = new();

  // Defining the size of arrays
  output_conv.wr_data = new[input_conv_h.no_of_i2c_bits_transfer/DATA_WIDTH];

  // Storing the values in the respective arrays
  //converting back the slave address 
  output_conv.slave_address = input_conv_h.slave_address;    
  `uvm_info("master_seq_item_conv_class",
  $sformatf("To class slave_address = \n %p",output_conv.slave_address),UVM_LOW)

  //converting back the register_address 
  output_conv.register_address = input_conv_h.register_address;
  `uvm_info("master_seq_item_conv_class",
  $sformatf("To class register_address = \n %p",output_conv.register_address),UVM_LOW)

 
  //converting back the data
  for(int i=0; i<input_conv_h.no_of_i2c_bits_transfer/DATA_WIDTH; i++) begin
  output_conv.wr_data[i] = input_conv_h.wr_data[i][DATA_WIDTH-1:0];
  `uvm_info("master_seq_item_conv_class",
  $sformatf("To class wr_data = \n %p",output_conv.wr_data[i]),UVM_LOW)
  end

  // Acknowledgement bits
  output_conv.slave_addr_ack = input_conv_h.slave_addr_ack;
  output_conv.reg_addr_ack = input_conv_h.reg_addr_ack;
  for(int i=0; i<input_conv_h.no_of_i2c_bits_transfer/DATA_WIDTH; i++) begin
    output_conv.wr_data_ack.push_back(input_conv_h.wr_data_ack[i]);
  end
  
endfunction: to_class

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void i2c_master_seq_item_converter::do_print(uvm_printer printer);

  i2c_transfer_bits_s i2c_st;
  super.do_print(printer);


  if(i2c_st.slave_address) begin
    printer.print_field($sformatf("slave_address"),i2c_st.slave_address,8,UVM_HEX);
  end
  
  if(i2c_st.register_address) begin
    printer.print_field($sformatf("register_address"),i2c_st.register_address,8,UVM_HEX);
  end

  foreach(i2c_st.wr_data[i]) begin
    printer.print_field($sformatf("wr_data[%0d]",i),i2c_st.wr_data[i],8,UVM_HEX);
  end

endfunction : do_print

`endif
