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

  //Variable : i2c_slave_tx_h
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

  int master_counter=0;

  int byte_data_cmp_verified_master_reg_addr_count = 0;

  int slave_counter=0;

  int byte_data_cmp_verified_slave_reg_addr_count = 0;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_scoreboard", uvm_component parent = null);
  //extern virtual function void build_phase(uvm_phase phase);
  //extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

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
    master_analysis_fifo=new("master_analysis_fifo",this);
    slave_analysis_fifo=new("slave_analysis_fifo",this);

endfunction : new



task i2c_scoreboard::run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin
    `uvm_info(get_type_name(),$sformatf("before calling master analysis fifo get method"),UVM_HIGH)
    master_analysis_fifo.get(i2c_master_tx_h);
    master_counter++;
    `uvm_info(get_type_name(),$sformatf("after calling master analysis fifo get method"),UVM_HIGH)
    `uvm_info(get_type_name(),$sformatf("printing i2c_master_tx_h, \n %s",i2c_master_tx_h.sprint()),UVM_HIGH)
    `uvm_info(get_type_name(),$sformatf("printing i2c_master_tx_h, \n %p,%d",i2c_master_tx_h,master_counter),UVM_HIGH)

    `uvm_info(get_type_name(),$sformatf("before calling slave analysis fifo get method"),UVM_HIGH)
    slave_analysis_fifo.get(i2c_slave_tx_h);
    slave_counter++;
    `uvm_info(get_type_name(),$sformatf("after calling slave analysis fifo get method"),UVM_HIGH)
    `uvm_info(get_type_name(),$sformatf("printing i2c_slave_tx_h, \n %s",i2c_slave_tx_h.sprint()),UVM_HIGH)
    `uvm_info(get_type_name(),$sformatf("CHETAN printing i2c_slave_tx_h, \n %p,%d",i2c_slave_tx_h,slave_counter),UVM_HIGH)
  
    foreach(i2c_master_tx_h.slave_address[i])
    begin
      if(i2c_master_tx_h.slave_address[i]==i2c_slave_tx_h.slave_address[i])
        begin
        `uvm_info(get_type_name(),$sformatf("address matched"),UVM_HIGH)
        `uvm_info("SB_SLAVE_ADDR_MATCHED", $sformatf("Master SLAVE_ADDR = %0d and Slave SLAVE_ADDR = %0d",i,i2c_master_tx_h.slave_address[i],i,i2c_slave_tx_h.slave_address[i]), UVM_HIGH); 

        byte_data_cmp_verified_master_reg_addr_count++;

        end
      else
        begin
        `uvm_info(get_type_name(),$sformatf("address mismatch"),UVM_HIGH)
        end
      end
  
  end


endtask : run_phase

`endif

