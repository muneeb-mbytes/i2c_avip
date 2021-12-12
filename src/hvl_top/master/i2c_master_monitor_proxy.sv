`ifndef I2C_MASTER_MONITOR_PROXY_INCLUDED_
`define I2C_MASTER_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_monitor_proxy
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_monitor_proxy extends uvm_component;
  `uvm_component_utils(i2c_master_monitor_proxy)

  i2c_master_agent_config i2c_master_agent_cfg_h;

  uvm_analysis_port #(i2c_master_tx)master_analysis_port;

  virtual i2c_master_monitor_bfm i2c_master_mon_bfm_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  //extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual function void reset_detected();
  extern virtual task run_phase(uvm_phase phase);

endclass : i2c_master_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_master_monitor_proxy::new(string name = "i2c_master_monitor_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  master_analysis_port = new("master_analysis_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_master_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual i2c_master_monitor_bfm)::get(this,"","i2c_master_monitor_bfm",i2c_master_mon_bfm_h))begin
    `uvm_fatal("CONFIG","cannot get the i2c_master_agent_cfg_h () . have you set it?")
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------

//function void i2c_master_monitor_proxy::connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
//endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_master_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  i2c_master_mon_bfm_h.i2c_master_mon_proxy_h = this;
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: reset detected
// This function detect the system reset application 
//
//--------------------------------------------------------------------------------------------
function void i2c_master_monitor_proxy::reset_detected();
  `uvm_info(get_type_name(), $sformatf("System reset is detected"), UVM_NONE);


endfunction : reset_detected

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task i2c_master_monitor_proxy::run_phase(uvm_phase phase);

  i2c_master_tx i2c_master_transfer;

  `uvm_info(get_type_name(), $sformatf("Inside the i2c_master_monitor_proxy"), UVM_NONE);

  i2c_master_transfer = i2c_master_tx::type_id::create("i2c_master_packet");

  i2c_master_mon_bfm_h.wait_for_reset();

  //i2c_master_mon_bfm_h.wait_for_ideal_state();

  // phase.raise_objection(this, "i2c_master_monitor_proxy");


  // Work here
  // ...

  //phase.drop_objection(this);

endtask : run_phase

`endif

