`ifndef I2C_BASE_TEST_INCLUDED_
`define I2C_BASE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_base_test
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_base_test extends uvm_test;
  `uvm_component_utils(i2c_base_test)

  i2c_env i2c_env_h;
  i2c_env_config i2c_env_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void setup_env_cfg();
  extern virtual function void setup_master_agent_cfg();
  extern virtual function void setup_slave_agent_cfg();
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : i2c_base_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_base_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_base_test::new(string name = "i2c_base_test",
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
function void i2c_base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  setup_env_cfg();

  i2c_env_h = i2c_env::type_id::create("i2c_env_h",this);

endfunction : build_phase




function void i2c_base_test::setup_env_cfg();
    i2c_env_cfg_h = i2c_env_config::type_id::create("i2c_env_cfg_h");
    i2c_env_cfg_h.no_of_masters = NO_OF_MASTERS;
    i2c_env_cfg_h.no_of_slaves = NO_OF_SLAVES;
    //i2c_env_cfg_h.has_scoreboard = 1;
    i2c_env_cfg_h.has_virtual_sequencer = 1;

    setup_master_agent_cfg();
    setup_slave_agent_cfg();

  
    uvm_config_db #(i2c_env_config)::set(this,"*","i2c_env_config",i2c_env_cfg_h);

    i2c_env_cfg_h.print();

    
 endfunction: setup_env_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_master_agent_cfg
// Setup the master agent configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void i2c_base_test::setup_master_agent_cfg();
  i2c_env_cfg_h.i2c_master_agent_cfg_h = new[i2c_env_cfg_h.no_of_masters];
  foreach(i2c_env_cfg_h.i2c_master_agent_cfg_h[i])begin

  i2c_env_cfg_h.i2c_master_agent_cfg_h[i] = i2c_master_agent_config::type_id::create($sformatf("i2c_master_agent_cfg_h[%0d]",i));
  // Configure the Master agent configuration
  i2c_env_cfg_h.i2c_master_agent_cfg_h[i].is_active           = uvm_active_passive_enum'(UVM_ACTIVE);
  //i2c_env_cfg_h.i2c_master_agent_cfg_h[i].no_of_slaves      = NO_OF_SLAVES;
  //i2c_env_cfg_h.i2c_master_agent_cfg_h.slave_address_width    = slave_address_width_e'(1'b0);
  //i2c_env_cfg_h.i2c_master_agent_cfg_h.shift_dir              = shift_direction_e'(LSB_FIRST);
  i2c_env_cfg_h.i2c_master_agent_cfg_h[i].has_coverage         = 1;


  uvm_config_db #(i2c_master_agent_config)::set(this,$sformatf("*2c_master_agent_h[%0d]*",i),"i2c_master_agent_config",i2c_env_cfg_h.i2c_master_agent_cfg_h[i]);
  i2c_env_cfg_h.i2c_master_agent_cfg_h[i].print();
end
endfunction: setup_master_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: setup_slave_agents_cfg
// Setup the slave agent(s) configuration with the required values
// and store the handle into the config_db
//--------------------------------------------------------------------------------------------
function void i2c_base_test::setup_slave_agent_cfg();
  // Create slave agent(s) configurations
  i2c_env_cfg_h.i2c_slave_agent_cfg_h = new[i2c_env_cfg_h.no_of_slaves];
  // Setting the configuration for each slave
  foreach(i2c_env_cfg_h.i2c_slave_agent_cfg_h[i]) begin
    i2c_env_cfg_h.i2c_slave_agent_cfg_h[i] = i2c_slave_agent_config::type_id::create($sformatf("salve_agent_cfg_h[%0d]",i));
    i2c_env_cfg_h.i2c_slave_agent_cfg_h[i].slave_id     = i;
    i2c_env_cfg_h.i2c_slave_agent_cfg_h[i].is_active    = uvm_active_passive_enum'(UVM_ACTIVE);
    //i2c_env_cfg_h.i2c_slave_agent_cfg_h[i].spi_mode     = operation_modes_e'(CPOL0_CPHA0);
    //i2c_env_cfg_h.i2c_slave_agent_cfg_h[i].shift_dir    = shift_direction_e'(LSB_FIRST);
    i2c_env_cfg_h.i2c_slave_agent_cfg_h[i].has_coverage = 1;

    // MSHAdb #(i2c_slave_agent_config)::set(this,"*slave_agent*",
    // MSHA:                                         $sformatf("i2c_slave_agent_config[%0d]",i),
    // MSHA:                                         i2c_env_cfg_h.salve_agent_cfg_h[i]);

    uvm_config_db #(i2c_slave_agent_config)::set(this,$sformatf("*slave_agent_h[%0d]*",i),
                                             "i2c_slave_agent_config", i2c_env_cfg_h.i2c_slave_agent_cfg_h[i]);
   i2c_env_cfg_h.i2c_slave_agent_cfg_h[i].print();
  end

endfunction: setup_slave_agent_cfg

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// Used for printing the testbench topology
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i2c_base_test::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used for giving basic delay for simulation 
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task i2c_base_test::run_phase(uvm_phase phase);

  phase.raise_objection(this, "i2c_base_test");

  `uvm_info(get_type_name(), $sformatf("Inside I2C_BASE_TEST"), UVM_NONE);
  super.run_phase(phase);

  // TODO(mshariff): 
  // Need to be replaced with delay task in BFM interface
  // in-order to get rid of time delays in HVL side
  #100;
  
  `uvm_info(get_type_name(), $sformatf("Done I2C_BASE_TEST"), UVM_NONE);
  phase.drop_objection(this);

endtask : run_phase
`endif

