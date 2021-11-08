`ifndef I2C_ENV_INCLUDED_
`define I2C_ENV_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_env
// Environment contains slave_agent_top,master_agent_top and virtual_sequencer
//--------------------------------------------------------------------------------------------
class i2c_env extends uvm_env;
  `uvm_component_utils(i2c_env)
  
  // Variable: i2c_master_agent_h
  // declaring i2c_master agent handle
  i2c_master_agent i2c_master_agent_h[];
  
  // Variable: i2c_slave_agent_h
  // Declaring i2c_slave handles
  i2c_slave_agent i2c_slave_agent_h[];

  // Variable: i2c_virtual_seqr_h
  // declaring handle for virtual sequencer
  i2c_virtual_sequencer i2c_virtual_seqr_h;
  
  // Variable: i2c_env_cfg_h
  // Declaring environment configuration handle
  i2c_env_config i2c_env_cfg_h;
  
  // Variable: scoreboard_h
  // declaring scoreboard handle
  i2c_scoreboard scoreboard_h;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_env", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : i2c_env

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_env
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_env::new(string name = "i2c_env",
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
function void i2c_env::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(i2c_env_config)::get(this,"","i2c_env_config",i2c_env_cfg_h)) begin
    `uvm_fatal("CONFIG","cannot get() the i2c_env_cfg_h from the uvm_config_db . Have you set it?")
  end
  
  i2c_master_agent_h=new[i2c_env_cfg_h.no_of_masters];
     
  foreach(i2c_master_agent_h[i])begin
    i2c_master_agent_h[i]=i2c_master_agent::type_id::create($sformatf("i2c_master_agent_h[%0d]",i),this);
  end
     
  i2c_slave_agent_h=new[i2c_env_cfg_h.no_of_slaves];    
      
  foreach(i2c_slave_agent_h[i])begin    
   i2c_slave_agent_h[i]=i2c_slave_agent::type_id::create($sformatf("i2c_slave_agent_h[%0d]",i),this);
  end
   
  if(i2c_env_cfg_h.has_virtual_sequencer)begin
   i2c_virtual_seqr_h=i2c_virtual_sequencer::type_id::create("virtual_seqr_h",this);
  end 
  
  if(i2c_env_cfg_h.has_scoreboard)begin
   scoreboard_h=i2c_scoreboard::type_id::create("scoreboard_h",this);
  end 

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(i2c_env_cfg_h.has_virtual_sequencer)
  begin
    foreach(i2c_master_agent_h[i])begin
      i2c_virtual_seqr_h.i2c_master_seqr_h=i2c_master_agent_h[i].i2c_master_seqr_h;
      i2c_master_agent_h[i].i2c_master_mon_proxy_h.master_analysis_port.connect(scoreboard_h.master_analysis_fifo.analysis_export); 
    end
    foreach(i2c_slave_agent_h[i])begin
      i2c_virtual_seqr_h.i2c_slave_seqr_h=i2c_slave_agent_h[i].i2c_slave_seqr_h;
      i2c_slave_agent_h[i].i2c_slave_mon_proxy_h.slave_analysis_port.connect(scoreboard_h.slave_analysis_fifo.analysis_export);
    end
  end
endfunction : connect_phase


`endif

