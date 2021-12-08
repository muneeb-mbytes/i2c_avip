`ifndef I2C_MASTER_BASE_SEQ_INCLUDED_
`define I2C_MASTER_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_base_seq 
// creating i2c_master_base_seq class extends from uvm_sequence
//--------------------------------------------------------------------------------------------

class i2c_master_base_seq extends uvm_sequence #(i2c_master_tx);
  //factory registration
  `uvm_object_utils(i2c_master_base_seq)
  `uvm_declare_p_sequencer(i2c_master_sequencer) 

  //-------------------------------------------------------
  // Externally defined Function
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_base_seq");
  extern virtual task body();
endclass : i2c_master_base_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_base_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function i2c_master_base_seq::new(string name = "i2c_master_base_seq");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
//task:body
//Creates the required ports
//
//Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------
task i2c_master_base_seq::body();

  //dynamic casting of p_sequencer and m_sequencer
  if(!$cast(p_sequencer,m_sequencer))begin
    `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
            
endtask:body

`endif
