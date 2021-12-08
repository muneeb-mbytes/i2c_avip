`ifndef I2C_8B_TEST_INCLUDED_
`define I2C_8B_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_8b_test
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_8b_test extends i2c_base_test;
  `uvm_component_utils(i2c_8b_test)

  i2c_8b_virtual_seq i2c_8b_virtual_seq_h;


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_8b_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : i2c_8b_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_8b_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_8b_test::new(string name = "i2c_8b_test",
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
function void i2c_8b_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void i2c_8b_test::connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
//endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task i2c_8b_test::run_phase(uvm_phase phase);


  i2c_8b_virtual_seq_h = i2c_8b_virtual_seq::type_id::create("i2c_8b_virtual_seq_h");


 // phase.raise_objection(this);


  i2c_8b_virtual_seq_h.start(i2c_env_h.i2c_virtual_seqr_h); 


  // phase.drop_objection(this);

endtask : run_phase

`endif


