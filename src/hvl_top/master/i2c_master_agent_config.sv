`ifndef I2C_MASTER_AGENT_CONFIG_INCLUDED_
`define I2C_MASTER_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_agent_config
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_agent_config extends uvm_object;
  `uvm_object_utils(i2c_master_agent_config)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;  

  // Variable: no_of_slaves
  // Used for specifying the number of slaves connected to 
  // this master over i2c interface
  int no_of_slaves;
  
  // Variable:read_write_e
  // Enables read or write operation 
  read_write_e read_write;

  shift_direction_e shift_dir;
  // Variable:slave_address_width_e
  // Used for enabling the address with  
  bit [SLAVE_ADDRESS_WIDTH-1:0] slave_address_array[];
  bit [7:0] register_address_array[int];

  // Variable: has_coverage
  // Used for enabling the master agent coverage
  bit has_coverage;

  constraint slave_addr{slave_address_array.size() inside {[0:3]};}
  
  constraint register_addr{register_address_array.size() inside {[0:3]};}
  
  constraint slave_addr_0{slave_address_array[0] == 7'b0000000;}
  constraint slave_addr_1{slave_address_array[1] == 7'b0000001;}
  constraint slave_addr_2{slave_address_array[2] == 7'b0000010;}
  constraint slave_addr_3{slave_address_array[3] == 7'b0000011;}


  constraint register_addr_0{
    if(slave_address_array[0] == 7'b0000000)
     register_address_array[0]==8'b00000000;
     register_address_array[1]==8'b00001000;
     register_address_array[2]==8'b00001001;
     register_address_array[3]==8'b10000000;
   }
    
  constraint register_addr_1{
    if(slave_address_array[1] == 7'b0000001)
     register_address_array[0]==8'b00010000;
     register_address_array[1]==8'b00101000;
     register_address_array[2]==8'b01001001;
     register_address_array[3]==8'b11000000;}
  
 // constraint register_addr{
 //   foreach(slave_address_array[i])begin
 //    register_address_array[i].size()>8'h00;
 //    register_address_array[i].size()<8'hff;
 //  end
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_agent_config");
  extern function void do_print(uvm_printer printer);
endclass : i2c_master_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_agent_config
//--------------------------------------------------------------------------------------------
function i2c_master_agent_config::new(string name = "i2c_master_agent_config");
  super.new(name);

endfunction : new


//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void i2c_master_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);


  printer.print_string ("is_active",is_active.name());
  printer.print_field ("no_of_slaves",no_of_slaves,$bits(no_of_slaves), UVM_DEC);
  printer.print_string ("shift_dir",shift_dir.name());
  printer.print_string ("read_write",read_write.name());
  printer.print_field ("has_coverage",has_coverage, 1, UVM_DEC);
  
endfunction : do_print

`endif
