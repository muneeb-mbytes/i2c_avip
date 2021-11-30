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

  // Variable: shift_dir
  // Shifts the data, LSB first or MSB first
  shift_direction_e shift_dir;

  // Variable:read_write_e
  // Enables read or write operation 
  read_write_e read_write;
  
  // Variable:slave_address_width_e
  // Used for enabling the address with  
  slave_address_width_e slave_address_width;

  // Variable: has_coverage
  // Used for enabling the master agent coverage
  bit has_coverage;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_agent_config");
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

`endif

