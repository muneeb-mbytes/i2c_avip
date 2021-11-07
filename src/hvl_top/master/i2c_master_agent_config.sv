`ifndef I2C_MASTER_AGENT_CONFIG_INCLUDED_
`define I2C_MASTER_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_agent_config
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_agent_config extends uvm_object;
  `uvm_object_utils(i2c_master_agent_config)

  //virtual spi_interface spi_if;

  int no_of_slaves;


  uvm_active_passive_enum is_active = UVM_ACTIVE;
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

