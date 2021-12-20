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
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
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
    `uvm_fatal("CONFIG","cannot get the i2c_master_mon_bfm_h () . have you set it?")
  end
endfunction : build_phase


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

  i2c_master_tx i2c_master_packet;

  `uvm_info(get_type_name(), $sformatf("Inside the i2c_master_monitor_proxy"), UVM_NONE);

  i2c_master_packet = i2c_master_tx::type_id::create("i2c_master_packet");
  
  // Wait for system reset
  i2c_master_mon_bfm_h.wait_for_reset();
  
  // Wait for the IDLE state of i2c interface
   i2c_master_mon_bfm_h.wait_for_idle_state();

  forever begin
    i2c_transfer_bits_s struct_packet;
    i2c_transfer_cfg_s struct_cfg;
    acknowledge_e ack;
    read_write_e rd_wr;


    i2c_master_tx i2c_master_clone_packet;

    //wait for the statrt condition
    i2c_master_mon_bfm_h.detect_start();

    
    
   // i2c_master_mon_bfm_h.wait_for_transfer_start();
    
    i2c_master_cfg_converter::from_class(i2c_master_agent_cfg_h, struct_cfg);

    // Sample the slave address from I2C bus
    i2c_master_mon_bfm_h.sample_slave_address(struct_cfg, ack, rd_wr);
    
    `uvm_info("DEBUG_MSHA", $sformatf("Slave address %0x :: Received ACK %0s", 
                                       struct_cfg.slave_address, ack.name()), UVM_NONE);
    i2c_master_mon_bfm_h.sample_reg_address(struct_packet,struct_cfg);

    i2c_master_seq_item_converter::to_class(struct_packet,i2c_master_packet);
    `uvm_info(get_type_name(), $sformatf("Received packet from BFM : \n%s",i2c_master_packet.sprint()),                                                                                 UVM_HIGH)
    
    // Clone and publish the cloned item to the subscribers
    $cast(i2c_master_clone_packet, i2c_master_packet.clone());
    `uvm_info(get_type_name(),$sformatf("Sending packet via analysis_port : , \n %s",
                                        i2c_master_clone_packet.sprint()),UVM_HIGH)
    master_analysis_port.write(i2c_master_clone_packet);

  end

endtask : run_phase

`endif

