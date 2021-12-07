`ifndef I2C_WRITE_MASTER_SEQ_INCLUDED_
`define I2C_WRITE_MASTER_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: extended class from base class
//--------------------------------------------------------------------------------------------
class i2c_write_master_seq extends i2c_master_base_seq;
  
  //register with factory so can use create uvm_method 
  //and override in future if necessary 
  `uvm_object_utils(i2c_write_master_seq)

  // master_tx req;

  //---------------------------------------------
  // Externally defined tasks and functions
  //---------------------------------------------

  extern function new (string name="i2c_write_master_seq");
  extern virtual task body();

endclass:i2c_write_master_seq

//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function i2c_write_master_seq::new(string name="i2c_write_master_seq");
  super.new(name);
endfunction:new

//-----------------------------------------------------------------------------
//task:body
//based on the request from driver task will drive the transaction
//-----------------------------------------------------------------------------
task i2c_write_master_seq::body();
  req = i2c_master_tx::type_id::create("req");begin

  start_item(req);

//  if(!req.randomize() with {req.data.size() == 1;
//                            req.reg_address.size() == 1;
//                           }) begin
//    `uvm_fatal(get_type_name(),"Randomization failed")
//  end
  req.print();
  finish_item(req);
end
endtask:body

`endif
