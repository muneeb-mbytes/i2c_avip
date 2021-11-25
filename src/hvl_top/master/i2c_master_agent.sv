`ifndef I2C_MASTER_AGENT_INCLUDED_
`define I2C_MASTER_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_agent
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_master_agent extends uvm_component;
  `uvm_component_utils(i2c_master_agent)

  i2c_master_agent_config i2c_master_agent_cfg_h;


  i2c_master_monitor_proxy i2c_master_mon_proxy_h;
  i2c_master_sequencer i2c_master_seqr_h;
  i2c_master_driver_proxy i2c_master_drv_proxy_h;
  i2c_master_coverage i2c_master_cov_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);

endclass : i2c_master_agent

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_master_agent::new(string name = "i2c_master_agent",
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
function void i2c_master_agent::build_phase(uvm_phase phase);
  
  super.build_phase(phase);
  if(!uvm_config_db #(i2c_master_agent_config)::get(this,"","i2c_master_agent_config",i2c_master_agent_cfg_h))
    `uvm_fatal("config","cannot get the config m_cfg from uvm_config_db. Have u set it ?")
    
    i2c_master_mon_proxy_h=i2c_master_monitor_proxy::type_id::create("i2c_master_mon_proxy_h",this);
  
  if(i2c_master_agent_cfg_h.is_active==UVM_ACTIVE)
  
  begin
    i2c_master_drv_proxy_h=i2c_master_driver_proxy::type_id::create("master_driver_h",this);
    i2c_master_seqr_h=i2c_master_sequencer::type_id::create("i2c_master_seqr_h",this);
  end

  if(i2c_master_agent_cfg_h.has_coverage)begin
    i2c_master_cov_h=i2c_master_coverage::type_id::create("master_cov_h",this);
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
function void i2c_master_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(i2c_master_agent_cfg_h.is_active==UVM_ACTIVE)begin
    
      i2c_master_drv_proxy_h.i2c_master_agent_cfg_h=i2c_master_agent_cfg_h;
      i2c_master_seqr_h.i2c_master_agent_cfg_h=i2c_master_agent_cfg_h;
      i2c_master_drv_proxy_h.seq_item_port.connect(i2c_master_seqr_h.seq_item_export);                        
   end                                                                                               
                                                                                                       
     if(i2c_master_agent_cfg_h.has_coverage) begin                                                         
         // MSHA: master_cov_h.master_agent_cfg_h = master_agent_cfg_h;                                  
        i2c_master_cov_h.i2c_master_agent_cfg_h = i2c_master_agent_cfg_h;                                          
            // TODO(mshariff):                                                                              
          // connect monitor port to coverage                                                             
                                                                                                           
            i2c_master_mon_proxy_h.master_analysis_port.connect(i2c_master_cov_h.analysis_export);                  
          end                                                                                               
                                                                                                            
          i2c_master_mon_proxy_h.i2c_master_agent_cfg_h = i2c_master_agent_cfg_h; 

endfunction : connect_phase
*/

`endif

