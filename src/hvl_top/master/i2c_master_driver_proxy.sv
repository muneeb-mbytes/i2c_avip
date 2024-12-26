`ifndef I2C_MASTER_DRIVER_PROXY_INCLUDED_
`define I2C_MASTER_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_driver_proxy
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_driver_proxy extends uvm_driver;
  `uvm_component_utils(i2c_master_driver_proxy)
 
  i2c_master_tx tx;

  i2c_master_agent_config i2c_master_agent_cfg_h;
  
  virtual i2c_master_driver_bfm i2c_master_driver_bfm_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  // extern virtual function void connect_phase(uvm_phase phase);
  // extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  // extern virtual task run_phase(uvm_phase phase);
  // extern virtual task drive_to_bfm(inout i2c_bits_transfer_s, input i2c_transfer_cfg_s);

endclass : i2c_master_driver_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_driver_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_master_driver_proxy::new(string name = "i2c_master_driver_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_master_driver_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  //   if(!uvm_config_db#(virtual i2c_master_driver_bfm)::set(null,"*","i2c_master_driver_bfm",i2c_master_driver_bfm_h));
  //    `uvm_fatal("CONFIG","cannot get () i2c_master_driver_bfm from uvm_config_db. Have you set it?")
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------

// function void i2c_master_driver_proxy::connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
// endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void i2c_master_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
//  super.end_of_elaboration_phase(phase);
//  i2c_master_driver_bfm_h.master_driver_proxy_h = this;
//endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//task i2c_master_driver_proxy::run_phase(uvm_phase phase);
//  super.run_phase(phase);
//
//  i2c_master_driver_bfm_h.wait_for_reset();
//
//  i2c_master_driver_bfm_h.drive_idle_state();
//
//  forever begin
//    i2c_bits_transfer_s struct_packet;
//    
//    i2c_transfer_cfg_s struct_cfg;
//  
//    seq_item_port.get_next_item(req);
//
//    i2c_master_driver_bfm_h.wait_for_idle_state();
//    
//    i2c_master_driver_bfm_h.start_condition();
//    
//    i2c_master_seq_item_converter::from_class(req, struct_packet);
//    
//    i2c_master_cfg_converter::from_class(i2c_master_agent_cfg_h, struct_cfg);
//
//    drive_to_bfm(struct_packet,struct_cfg);
//
//    i2c_master_seq_item_converter::to_class(struct_packet,req);
//    
//    seq_item_port.item_done();
//
//  end
//endtask : run_phase
//
//task i2c_master_driver_proxy :: drive_to_bfm(inout i2c_bits_transfer_s packet, input i2c_transfer_cfg_s packet1)
//  i2c_master_driver_bfm_h.drive_data(packet,packet1); 
//  `uvm_info(get_type_name(),$sformatf("AFTER STRUCT PACKET : , \n %p",packet1),UVM_LOW);
//endfunction

`endif
