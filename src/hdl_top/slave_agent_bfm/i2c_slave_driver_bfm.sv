`ifndef I2C_SLAVE_DRIVER_BFM_INCLUDED_
`define I2C_SLAVE_DRIVER_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class    :i2c_slave_driver_bfm
// Description  : Connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
import i2c_globals_pkg::*;
interface i2c_slave_driver_bfm #(parameter string NAME = "I2C_SLAVE_DRIVER_BFM")
                               (input pclk, 
                               input areset,
                               input scl_i,
                               output reg scl_o,
                               output reg scl_oen,
                               input sda_i,
                               output reg sda_o,
                               output reg sda_oen);
  
  i2c_fsm_state_e state;

  //-------------------------------------------------------
  // Importing UVM Package 
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  //-------------------------------------------------------
  // Importing I2C Global Package and Slave package
  //-------------------------------------------------------
  import i2c_slave_pkg::i2c_slave_driver_proxy;
  
  //Variable : slave_driver_proxy_h
  //Creating the handle for proxy driver
  i2c_slave_driver_proxy i2c_slave_drv_proxy_h;
  
  
  initial begin
    $display(NAME);
  end
  
  //-------------------------------------------------------
  // Task: wait_for_system_reset
  // Waiting for system reset to be active
  //-------------------------------------------------------
   task wait_for_system_reset();
     @(negedge areset);
     `uvm_info(NAME, $sformatf("System reset detected"), UVM_HIGH);
     @(posedge areset);
     `uvm_info(NAME , $sformatf("System reset deactivated"), UVM_HIGH);
   endtask: wait_for_system_reset
  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for I2C bus to be in IDLe state (SCL=1 and SDA=1)
  //-------------------------------------------------------
  task wait_for_idle_state();
    @(posedge pclk);
  
    while(scl_i!=1 && sda_i!=1) begin
      @(posedge pclk);
    end
      
    `uvm_info(NAME, $sformatf("I2C bus is free state detected"), UVM_HIGH);
  endtask: wait_for_idle_state
  
  //--------------------------------------------------------------------------------------------
  // Task: detect_start
  // Detects the START condition over I2C bus
  //--------------------------------------------------------------------------------------------
  task detect_start();
    @(posedge pclk);

    // TODO(mshariff): Need to fine-tune the logic to detect the edge on sda
    while(scl_i!=1 && sda_i!=0) begin
      @(posedge pclk);
    end
      
    `uvm_info(NAME, $sformatf("Start condition is detected"), UVM_HIGH);
    state = START;
  endtask: detect_start
  
  //-------------------------------------------------------
  // Task: detect_posedge_scl
  // Detects the edge on scl with regards to pclk
  //-------------------------------------------------------
  task detect_posedge_scl();
    // 2bit shift register to check the edge on scl
    bit [1:0] scl_local;
    edge_detect_e scl_edge_value;

    // Detect the edge on scl
    do begin

      @(negedge pclk);
      scl_local = {scl_local[0], scl_i};

    end while(!(scl_local == POSEDGE));

    scl_edge_value = edge_detect_e'(scl_local);
    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("scl %s detected", scl_edge_value.name()), UVM_HIGH);
  
  endtask: detect_posedge_scl
  
  //--------------------------------------------------------------------------------------------
  // Task: sample_slave_address
  // Samples the slave address from the I2C bus 
  //
  // Parameters:
  //  address - The slave address value (7bit or 10bit value)
  //
  // Returns:
  //  ack - Returns positive ack when the address matches with its slave address, otherwise 
  //  returns negative ack
  //--------------------------------------------------------------------------------------------
  task sample_slave_address(input i2c_transfer_cfg_s cfg_pkt, output acknowledge_e ack);
    bit [SLAVE_ADDRESS_WIDTH-1:0] local_addr;

    for(int i=0, bit_no=0; i<SLAVE_ADDRESS_WIDTH; i++) begin 
      // Logic for MSB first or LSB first 
      bit_no = cfg_pkt.msb_first ? ((SLAVE_ADDRESS_WIDTH - 1) - i) : i;

      detect_posedge_scl();
      local_addr[bit_no] = sda_i;
    end

    `uvm_info("DEBUG_MSHA", $sformatf("Value of local_addr = %0x", local_addr), UVM_NONE); 
   
    // Check if the sampled address belongs to this slave
    if(local_addr != cfg_pkt.slave_address) begin
      ack = NEG_ACK;
    end
    else begin
      ack = POS_ACK;
    end
    
    // Driving the ACK for slave address
    detect_posedge_scl();
    drive_sda(ack); 

  endtask: sample_slave_address

  //--------------------------------------------------------------------------------------------
  // Task: drive_sda 
  // Drive the logic sda value as '0' or '1' over the I2C inteerface using the tristate buffers
  //--------------------------------------------------------------------------------------------
  task drive_sda(input bit value);
    sda_oen <= value ? TRISTATE_BUF_OFF : TRISTATE_BUF_ON;
    sda_o   <= value;
  endtask: drive_sda



`endif
endinterface : i2c_slave_driver_bfm
