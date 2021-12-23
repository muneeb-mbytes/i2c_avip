`ifndef I2C_MASTER_DRIVER_PROXY_INCLUDED_
`define I2C_MASTER_DRIVER_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_driver_proxy
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_driver_proxy extends uvm_driver#(i2c_master_tx);
  `uvm_component_utils(i2c_master_driver_proxy)
 
  i2c_master_tx tx;

  i2c_master_agent_config i2c_master_agent_cfg_h;
  
  virtual i2c_master_driver_bfm i2c_master_drv_bfm_h;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_driver_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task drive_to_bfm(inout i2c_transfer_bits_s packet, 
                                   input i2c_transfer_cfg_s packet1);

endclass : i2c_master_driver_proxy

//---------------------------------------i2c_master_drv_proxy_h i2c_master_drv_proxy_h -----------------------------------------------------
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
  if(!uvm_config_db#(virtual i2c_master_driver_bfm)::get(this,"","i2c_master_driver_bfm",i2c_master_drv_bfm_h))
  `uvm_fatal("FATAL_MDP_CANNOT_GET_MASTER_DRIVER_BFM","cannot get () i2c_master_driver_bfm from uvm_config_db")
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_master_driver_proxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
   i2c_master_drv_bfm_h.i2c_master_drv_proxy_h = this;
endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task i2c_master_driver_proxy::run_phase(uvm_phase phase);

  super.run_phase(phase);

  i2c_master_drv_bfm_h.wait_for_reset();

  i2c_master_drv_bfm_h.drive_idle_state();

  forever begin
    i2c_transfer_bits_s struct_packet;
    i2c_transfer_cfg_s struct_cfg;
  
    `uvm_info("DEBUG_MSHA", "Inside i2c_master_driver_proxy", UVM_NONE);

    i2c_master_drv_bfm_h.wait_for_idle_state();

    seq_item_port.get_next_item(req);
    
    `uvm_info(get_type_name(), $sformatf("Received req\n%s",req.sprint()), UVM_HIGH)
    i2c_master_seq_item_converter::from_class(req, struct_packet);
    `uvm_info(get_type_name(), $sformatf("Converted req struct\n%p",struct_packet), UVM_HIGH)

    i2c_master_cfg_converter::from_class(i2c_master_agent_cfg_h, struct_cfg);

    drive_to_bfm(struct_packet,struct_cfg);

    i2c_master_seq_item_converter::to_class(struct_packet,req);
    `uvm_info(get_type_name(), $sformatf("After :: Received req\n%s",req.sprint()), UVM_HIGH)
    // MSHA: `uvm_info(get_type_name(), $sformatf("After :: Converted req struct\n%p",struct_packet), UVM_HIGH)
    
   seq_item_port.item_done();
   `uvm_info(get_type_name(), $sformatf("Completed Item Done\n%s",req.sprint()), UVM_HIGH)

  end
endtask : run_phase
//
task i2c_master_driver_proxy::drive_to_bfm(inout i2c_transfer_bits_s packet, 
                                           input  i2c_transfer_cfg_s packet1);
  i2c_master_drv_bfm_h.drive_data(packet,packet1); 
  `uvm_info(get_type_name(),$sformatf("AFTER STRUCT PACKET : , \n %p",packet1),UVM_LOW);
endtask: drive_to_bfm

`endif
