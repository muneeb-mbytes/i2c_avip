`ifndef I2C_SCOREBOARD_INCLUDED_
`define I2C_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_scoreboard
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_scoreboard extends uvm_component;
  `uvm_component_utils(i2c_scoreboard)

  //Variable : i2c_master_tx_h
  //declaring master transaction handle
  i2c_master_tx i2c_master_tx_h;

  //Variable : i2c_salve_tx_h
  //declaring slave transaction handle
  i2c_slave_tx i2c_slave_tx_h;

  //Variable : i2c_env_cfg_h
  //declaring environment configuration handle
  i2c_env_config i2c_env_cfg_h;

  //Variable : master_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(i2c_master_tx)master_analysis_fifo;
  
  //Variable : slave_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(i2c_slave_tx)slave_analysis_fifo;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  //extern virtual task run_phase(uvm_phase phase);

endclass : i2c_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_scoreboard::new(string name = "i2c_scoreboard",
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
function void i2c_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  master_analysis_fifo=new("master_analysis_fifo",this);
  slave_analysis_fifo=new("slave_analysis_fifo",this);

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_scoreboard::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase


`endif

