`ifndef I2C_SLAVE_CFG_CONVERTER_INCLUDED_
`define I2C_SLAVE_CFG_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// class : i2c_slave_cfg_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class i2c_slave_cfg_converter extends uvm_object;
  
  //static int c2t;
  //static int t2c;
  //static int baudrate_divisor;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_slave_cfg_converter");
  extern static function void from_class(input i2c_slave_agent_config input_conv_h,
                                          output i2c_transfer_cfg_s output_conv);

  extern function void do_print(uvm_printer printer);

endclass : i2c_slave_cfg_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_slave_cfg_converter
//--------------------------------------------------------------------------------------------
function i2c_slave_cfg_converter::new(string name = "i2c_slave_cfg_converter");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------
function void i2c_slave_cfg_converter::from_class(input i2c_slave_agent_config input_conv_h,
                                                    output i2c_transfer_cfg_s output_conv);

  output_conv.msb_first = input_conv_h.shift_dir;
  output_conv.slave_address = input_conv_h.slave_address; 

endfunction: from_class 

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void i2c_slave_cfg_converter::do_print(uvm_printer printer);

  i2c_transfer_cfg_s i2c_st;

  super.do_print(printer);


endfunction : do_print

`endif
