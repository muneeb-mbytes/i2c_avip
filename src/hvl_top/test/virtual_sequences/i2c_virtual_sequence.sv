`ifndef I2C_VIRTUAL_SEQUENCE_INCLUDED_
`define I2C_VIRTUAL_SEQUENCE_INCLUDED_

//--------------------------------------------------------------------------------------------
//Class:i2c_Virtual_sequence
// Description:
// This class contains the handle of actual sequencer pointing towards them
//--------------------------------------------------------------------------------------------


class i2c_virtual_sequence extends uvm_sequence#(uvm_sequence_item);
  `uvm_object_utils(i2c_virtual_sequence)

   //p sequencer macro declaration 
   `uvm_declare_p_sequencer(virtual_sequencer)
        
   //declaring virtual sequencer handle
   //virtual_sequencer  virtual_seqr_h;

   //--------------------------------------------------------------------------------------------
   // declaring handles for master and slave sequencer and environment config
   //--------------------------------------------------------------------------------------------
   i2c_master_sequencer  i2c_master_seqr_h;
   i2c_slave_sequencer   i2c_slave_seqr_h;
   i2c_env_config i2c_env_cfg_h;
   
   //--------------------------------------------------------------------------------------------
   // Externally defined tasks and functions
   //--------------------------------------------------------------------------------------------
   extern function new(string name="i2c_virtual_sequence");
   extern task body();
  
endclass:i2c_virtual_sequence
 
//--------------------------------------------------------------------------------------------
//Constructor:new
//
//Paramters:
//name - Instance name of the virtual_sequence
//parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
            
function i2c_virtual_sequence::new(string name="i2c_virtual_sequence");
  super.new(name);
endfunction:new
  
//--------------------------------------------------------------------------------------------
//task:body
//Creates the required ports
//
//Parameters:
// phase - stores the current phase
//--------------------------------------------------------------------------------------------
task i2c_virtual_sequence::body();
  if(!uvm_config_db#(i2c_env_config) ::get(null,get_full_name(),"i2c_env_config",i2c_env_cfg_h)) begin
  `uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db.Have you set() it?")
  end
 

  //dynamic casting of p_sequncer and m_sequencer
  if(!$cast(p_sequencer,m_sequencer))begin
  `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
                                             
  //connecting master sequencer and slave sequencer present in p_sequencer to
  // local master sequencer and slave sequencer 
  i2c_master_seqr_h=p_sequencer.i2c_master_seqr_h;
  i2c_slave_seqr_h=p_sequencer.i2c_slave_seqr_h;

endtask:body

`endif
