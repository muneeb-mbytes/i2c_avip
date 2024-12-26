`ifndef I2C_SLAVE_AGENT_INCLUDED_
`define I2C_SLAVE_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_slave_agent
// This agent has sequencer, driver_proxy, monitor_proxy for SPI  
//--------------------------------------------------------------------------------------------
class i2c_slave_agent extends uvm_component;
  `uvm_component_utils(i2c_slave_agent)

  i2c_slave_agent_config i2c_slave_agent_cfg_h;
  
  i2c_slave_monitor_proxy i2c_slave_mon_proxy_h;
  i2c_slave_sequencer i2c_slave_seqr_h;
  i2c_slave_driver_proxy i2c_slave_drv_proxy_h;
  i2c_slave_coverage i2c_slave_cov_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_slave_agent",uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);

endclass : i2c_slave_agent

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_slave_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_slave_agent::new(string name = "i2c_slave_agent",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports, gets the required configuration from config_db
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_slave_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(i2c_slave_agent_config)::get(this,"","i2c_slave_agent_config",i2c_slave_agent_cfg_h))
    `uvm_fatal("CONFIG","cannot get() the i2c_slave_agent_cfg_h from the uvm_config_db. have you set it?")
    
    i2c_slave_mon_proxy_h=i2c_slave_monitor_proxy::type_id::create("i2c_slave_mon_proxy_h",this);

    if(i2c_slave_agent_cfg_h.is_active==UVM_ACTIVE)
      begin

        i2c_slave_drv_proxy_h=i2c_slave_driver_proxy::type_id::create("i2c_slave_drv_proxy_h",this);
        i2c_slave_seqr_h=i2c_slave_sequencer::type_id::create("i2c_slave_seqr_h",this);
      
      end

      if(i2c_slave_agent_cfg_h.has_coverage)begin

        i2c_slave_cov_h=i2c_slave_coverage::type_id::create("i2c_slave_cov_h",this);
      end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
/*
function void i2c_slave_agent::connect_phase(uvm_phase phase);

  if(s_cfg.is_active==UVM_ACTIVE)
  begin
    i2c_slave_drv_proxy_h.seq_item_port.connect(i2c_slave_seqr_h.seq_item_export);
  end
endfunction : connect_phase
*/

`endif

