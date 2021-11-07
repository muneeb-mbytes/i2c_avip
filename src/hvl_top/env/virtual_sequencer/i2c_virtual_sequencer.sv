`ifndef I2C_VIRTUAL_SEQUENCER_INCLUDED_
`define I2C_VIRTUAL_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_virtual_sequencer
// Description of the class.
//  
// This class contains the handle of actual sequencer pointing towards them
//--------------------------------------------------------------------------------------------
class i2c_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
  `uvm_component_utils(i2c_virtual_sequencer)
  
  // Variable: env_cfg_h
  // Declaring environment configuration handle
  i2c_env_config i2c_env_cfg_h;

  // Variable: master_seqr_h
  // Declaring master sequencer handle
  i2c_master_sequencer i2c_master_seqr_h;

  // Variable: slave_seqr_h
  // Declaring slave sequencer handle
  i2c_slave_sequencer  i2c_slave_seqr_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_virtual_sequencer", uvm_component parent );
  extern i2c_virtual function void build_phase(uvm_phase phase);

endclass : i2c_virtual_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
// initializes the monitor class object
//
// Parameters:
//  name - instance name of the  i2c_virtual_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_virtual_sequencer::new(string name = "i2c_virtual_sequencer",uvm_component parent );
    super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// creates the required ports
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void i2c_virtual_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h))
  `uvm_error("VSEQR","COULDNT GET")
  
  //slave_seqr_h = new[env_cfg_h.no_of_sagent];
  i2c_master_seqr_h = i2c_master_sequencer::type_id::create("i2c_master_seqr_h",this);
  i2c_slave_seqr_h = i2c_slave_sequencer::type_id::create("i2c_slave_seqr_h",this);
  
endfunction : build_phase


`endif

