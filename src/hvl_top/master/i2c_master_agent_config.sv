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
 
  // Variable: no_of_mastesr
  // Used for specifying the number of mastesr connected to 
  int no_of_masters;


  // Variable: shift_dir
  // Shifts the data, LSB first or MSB first
  shift_direction_e shift_dir;

  // Variable:read_write_e
  // Enables read or write operation 
  read_write_e read_write;
  
  // Variable: has_coverage
  // Used for enabling the master agent coverage
  bit has_coverage;

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

<<<<<<< HEAD
=======

>>>>>>> eb2c30b053f80320e7eccda8e8968ea496b86512
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
