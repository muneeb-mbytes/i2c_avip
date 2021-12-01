`ifndef I2C_MASTER_SEQ_ITEM_CONVERTER_INCLUDED_
`define I2C_MASTER_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// class : i2c_master_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class i2c_master_seq_item_converter extends uvm_object;
  
  //static int c2t;
  //static int t2c;
  //static int baudrate_divisor;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_seq_item_converter");
  extern static function void from_class(input i2c_master_tx input_conv_h,
                                          output i2c_slave_address_s output_conv_s, 
                                          output i2c_register_address_s output_conv_r,
                                          output i2c_transfer_data_s output_conv_d);

  extern static function void to_class(input i2c_slave_address_s input_conv_s,     
                                        input i2c_register_address_s input_conv_r,    
                                        input i2c_transfer_data_s input_conv_d,
                                        output i2c_master_tx output_conv_h);
  extern function void from_class_msb_first(input i2c_master_tx input_conv_h, 
                                            output i2c_transfer_data_s output_conv);
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
                                                        output i2c_slave_address_s output_conv_s,
                                                        output i2c_register_address_s output_conv_r,
                                                        output i2c_transfer_data_s output_conv_d);

  output_conv_s.no_of_slave_address_bits_transfer = input_conv_h.slave_address.size()*SLAVE_ADDRESS_WIDTH;
  output_conv_r.no_of_register_address_bits_transfer = input_conv_h.register_address.size()*REGISTER_ADDRESS_WIDTH;
  output_conv_d.no_of_data_bits_transfer = input_conv_h.data.size()*DATA_LENGTH;

  for(int i=0; i<input_conv_h.slave_address.size();i++) begin

    `uvm_info("master_seq_item_conv_class",
    $sformatf("data = \n %p",output_conv_s.slave_address),UVM_LOW)
    output_conv_s.slave_address[i][SLAVE_ADDRESS_WIDTH-1:0] = input_conv_h.slave_address[i];    

    `uvm_info("master_seq_item_conv_class",
    $sformatf("data = \n %p",output_conv_s.slave_address),UVM_LOW)
  end

  for(int i=0; i<input_conv_h.register_address.size();i++) begin

    `uvm_info("master_seq_item_conv_class",
    $sformatf("data = \n %p",output_conv_r.register_address),UVM_LOW)
    output_conv_r.register_address[i][REGISTER_ADDRESS_WIDTH-1:0] = input_conv_h.register_address[i];    

    `uvm_info("master_seq_item_conv_class",
    $sformatf("data = \n %p",output_conv_r.register_address),UVM_LOW)
  end

  
  for(int i=0; i<input_conv_h.data.size();i++) begin
    `uvm_info("master_seq_item_conv_class",
    $sformatf("data = \n %p",output_conv_d.data),UVM_LOW)
   // output_conv.data = output_conv.data << DATA_LENGTH;
    `uvm_info("master_seq_item_conv_class",
    $sformatf("After shift data = \n %p",output_conv_d.data),UVM_LOW)
    `uvm_info("master_seq_item_conv_class",
    $sformatf("After shift input_cov_h data = \n %p",
    input_conv_h.data[i]),UVM_LOW)
    output_conv_d.data[i][DATA_LENGTH-1:0] = input_conv_h.data[i];    
    `uvm_info("master_seq_item_conv_class",
    $sformatf("After shift input_cov_h data = \n %p",
    input_conv_h.data[i]),UVM_LOW)
    //output_conv.data[i*8 +: 8]= input_conv_h.data[i];    
    
    `uvm_info("master_seq_item_conv_class",
    $sformatf("data = \n %p",output_conv_d.data),UVM_LOW)
  end



endfunction: from_class 

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items when msb is high
//--------------------------------------------------------------------------------------------
function void i2c_master_seq_item_converter::from_class_msb_first(input i2c_master_tx input_conv_h,
                                                           output i2c_transfer_data_s output_conv_d);
  
  output_conv_d.no_of_data_bits_transfer = input_conv_h.data.size()*DATA_LENGTH;
  
  for(int i=output_conv_d.no_of_data_bits_transfer; i>0; i++) begin
    output_conv_d.data[i] = input_conv_h.data[i];
  end

endfunction: from_class_msb_first

//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------
function void i2c_master_seq_item_converter::to_class(input i2c_slave_address_s input_conv_s,
                                                      input i2c_register_address_s input_conv_r,
                                                      input i2c_transfer_data_s input_conv_d,
                                                      output i2c_master_tx output_conv_s_h,
                                                    output i2c_master_tx output_conv_r_h,
                                                    output i2c_master_tx output_conv_d_h);
  output_conv_s_h = new();
  output_conv_r_h = new();
  output_conv_d_h = new();

  // Defining the size of arrays
  output_conv_s_h.slave_address = new[input_conv_s.no_of_slave_address_bits_transfer/SLAVE_ADDRESS_WIDTH];
  output_conv_r_h.register_address = new[input_conv_r.no_of_register_address_bits_transfer/REGISTER_ADDRESS_WIDTH];
  output_conv_d_h.data = new[input_conv_d.no_of_data_bits_transfer/DATA_LENGTH];

  // Storing the values in the respective arrays
  
  for(int i=0; i<input_conv_s.no_of_slave_address_bits_transfer/SLAVE_ADDRESS_WIDTH; i++) begin
    output_conv_s_h.slave_address[i] = input_conv_s.slave_address[i][SLAVE_ADDRESS_WIDTH-1:0];
    `uvm_info("master_seq_item_conv_class",
    $sformatf("To class slave_address = \n %p",output_conv_h.slave_address[i]),UVM_LOW)
  end

  for(int i=0; i<input_conv_r.no_of_register_address_bits_transfer/REGISTER_ADDRESS_WIDTH; i++) begin
    output_conv_r_h.register_address[i] = input_conv_r.register_address[i][REGISTER_ADDRESS_WIDTH-1:0];
    `uvm_info("master_seq_item_conv_class",
    $sformatf("To class register_address = \n %p",output_conv_h.register_address[i]),UVM_LOW)
  end

  for(int i=0; i<input_conv_d.no_of_data_bits_transfer/DATA_LENGTH; i++) begin
    output_conv_d_h.data[i] = input_conv_d.data[i][DATA_LENGTH-1:0];
    `uvm_info("master_seq_item_conv_class",
    $sformatf("To class data = \n %p",output_conv_h.data[i]),UVM_LOW)
  end

  
endfunction: to_class

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void i2c_master_seq_item_converter::do_print(uvm_printer printer);

  i2c_transfer_data_s i2c_st;
  super.do_print(printer);


  foreach(i2c_st.slave_address[i]) begin
    printer.print_field($sformatf("slave_address[%0d]",i),i2c_st.slave_address[i],8,UVM_HEX);
  end

  foreach(i2c_st.register_address[i]) begin
    printer.print_field($sformatf("register_address[%0d]",i),i2c_st.register_address[i],8,UVM_HEX);
  end
 
  foreach(i2c_st.data[i]) begin
    printer.print_field($sformatf("data[%0d]",i,),i2c_st.data[i],8,UVM_HEX);
  end

endfunction : do_print

`endif
