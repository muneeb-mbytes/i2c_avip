`ifndef I2C_SLAVE_MONITOR_PROXY_INCLUDED_
`define I2C_SLAVE_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_slave_monitor_proxy
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_slave_monitor_proxy extends uvm_component;
  `uvm_component_utils(i2c_slave_monitor_proxy)

  i2c_slave_agent_config i2c_slave_agent_cfg_h;

  virtual i2c_slave_monitor_bfm i2c_slave_mon_bfm_h; 


  uvm_analysis_port #(i2c_slave_tx)slave_analysis_port;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_slave_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : i2c_slave_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_slave_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_slave_monitor_proxy::new(string name = "i2c_slave_monitor_proxy",
                                 uvm_component parent = null);

  super.new(name, parent);

  slave_analysis_port = new("slave_analysis_port",this);

endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_slave_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
   // Getting the config db
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_slave_monitor_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  `uvm_info(get_type_name(),$sformatf("Inside slave_monitor_proxy,slave_id=%0d",i2c_slave_agent_cfg_h),UVM_LOW);
  if(!uvm_config_db #(virtual i2c_slave_monitor_bfm)::get(this,"",$sformatf("i2c_slave_monitor_bfm_%0d",i2c_slave_agent_cfg_h.slave_id),i2c_slave_mon_bfm_h))begin
    `uvm_fatal("FATAL_SDP_CANNOT_GET_SLAVE_MONITOR_BFM","cannot get i2c_slave_monitor_bfm from the uvm_config_db. Have you set it?");
  end
  i2c_slave_mon_bfm_h.i2c_slave_mon_proxy_h = this;
  i2c_slave_mon_bfm_h.slave_id = i2c_slave_agent_cfg_h.slave_id;
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task i2c_slave_monitor_proxy::run_phase(uvm_phase phase);

  i2c_slave_tx i2c_slave_packet;
  `uvm_info(get_type_name(),$sformatf("Inside slave_monitor_proxy"),UVM_LOW);
  i2c_slave_packet = i2c_slave_tx::type_id::create("i2c_slave_packet");
  
  i2c_slave_mon_bfm_h.wait_for_system_reset();
  i2c_slave_mon_bfm_h.wait_for_idle_state();
  
  forever begin
    i2c_transfer_bits_s struct_packet;
    i2c_transfer_cfg_s struct_cfg;
    acknowledge_e ack;
    read_write_e rd_wr;
    i2c_slave_tx i2c_slave_clone_packet;

    //wait for the statrt condition
    i2c_slave_mon_bfm_h.detect_start();

    // i2c_slave_mon_bfm_h.wait_for_transfer_start();
    i2c_slave_cfg_converter::from_class(i2c_slave_agent_cfg_h, struct_cfg);

    // Sample the slave address from I2C bus
    i2c_slave_mon_bfm_h.sample_slave_address(struct_cfg, struct_packet, ack, rd_wr);
    
    `uvm_info("DEBUG_NADEEM", $sformatf("Slave address %0x :: Received ACK %0s", 
                                       struct_cfg.slave_address, ack.name()), UVM_NONE);
    `uvm_info("DEBUG_NADEEM10", $sformatf("Slave address %0x :: Received ACK %0s", 
                                       struct_packet.slave_address, ack.name()), UVM_NONE);
    `uvm_info("DEBUG_NADEEM20", $sformatf("Struct packet %0p", 
                                       struct_packet), UVM_NONE);
    i2c_slave_seq_item_converter::to_class(struct_packet,i2c_slave_packet);
    `uvm_info("Saketh", $sformatf("Received packet from BFM : \n%s",i2c_slave_packet.sprint()),UVM_HIGH)

    // i2c_slave_mon_bfm_h.sample_reg_address(struct_packet,struct_cfg);
    // `uvm_info("mukul", $sformatf("Received packet from BFM : \n%s",.sprint()),UVM_HIGH)

    
    // Clone and publish the cloned item to the subscribers
    $cast(i2c_slave_clone_packet, i2c_slave_packet.clone());
    `uvm_info(get_type_name(),$sformatf("Nadeem40 Sending packet via analysis_port : , \n %s",
                                        i2c_slave_clone_packet.sprint()),UVM_HIGH)
    slave_analysis_port.write(i2c_slave_clone_packet);
  
  end

 endtask : run_phase

`endif

