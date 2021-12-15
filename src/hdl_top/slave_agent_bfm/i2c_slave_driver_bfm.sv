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

  int slave_id;

  string name;

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
    $display(name);
  end
  
  //-------------------------------------------------------
  // Task: wait_for_system_reset
  // Waiting for system reset to be active
  //-------------------------------------------------------
   task wait_for_system_reset();
     // TODO(mshariff): Need to re-do this 'name' logic
     `uvm_info("DEBUG_MSHA", $sformatf("slave_id = %0d", slave_id), UVM_NONE); 
     name = {NAME, "_", $sformatf("%0d",slave_id)};

     @(negedge areset);
     `uvm_info(name, $sformatf("System reset detected"), UVM_HIGH);
     @(posedge areset);
     `uvm_info(name , $sformatf("System reset deactivated"), UVM_HIGH);
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
      
    `uvm_info(name, $sformatf("I2C bus is free state detected"), UVM_HIGH);
  endtask: wait_for_idle_state
  
  //--------------------------------------------------------------------------------------------
  // Task: detect_start
  // Detects the START condition over I2C bus
  //--------------------------------------------------------------------------------------------
  task detect_start();
    // 2bit shift register to check the edge on sda and stability on scl
    bit [1:0] scl_local;
    bit [1:0] sda_local;

    // Detect the edge on scl
    do begin

      @(negedge pclk);
      scl_local = {scl_local[0], scl_i};
      sda_local = {sda_local[0], sda_i};

    end while(!(sda_local == NEGEDGE && scl_local == 2'b11) );

    state = START;
    `uvm_info(name, $sformatf("Start condition is detected"), UVM_HIGH);
  endtask: detect_start
  
  //-------------------------------------------------------
  // Task: detect_posedge_scl
  // Detects the edge on scl with regards to pclk
  //-------------------------------------------------------
  task detect_posedge_scl();
    // 2bit shift register to check the edge on scl
    bit [1:0] scl_local;
    edge_detect_e scl_edge_value;

    // default value of scl_local is logic 1
    scl_local = 2'b11;

    // Detect the edge on scl
    do begin

      @(negedge pclk);
      scl_local = {scl_local[0], scl_i};

    end while(!(scl_local == POSEDGE));

    scl_edge_value = edge_detect_e'(scl_local);
    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("scl %s detected", scl_edge_value.name()), UVM_HIGH);
  
  endtask: detect_posedge_scl
  
  //-------------------------------------------------------
  // Task: detect_negedge_scl
  // Detects the negative edge on scl with regards to pclk
  //-------------------------------------------------------
  task detect_negedge_scl();
    // 2bit shift register to check the edge on scl
    bit [1:0] scl_local;
    edge_detect_e scl_edge_value;

    // default value of scl_local is logic 1
    scl_local = 2'b11;

    // Detect the edge on scl
    do begin

      @(negedge pclk);
      scl_local = {scl_local[0], scl_i};

    end while(!(scl_local == NEGEDGE));

    scl_edge_value = edge_detect_e'(scl_local);
    `uvm_info("SLAVE_DRIVER_BFM", $sformatf("scl %s detected", scl_edge_value.name()), UVM_HIGH);
  
  endtask: detect_negedge_scl
  
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
  task sample_slave_address(input i2c_transfer_cfg_s cfg_pkt, output acknowledge_e ack, output read_write_e rd_wr);
    bit [SLAVE_ADDRESS_WIDTH-1:0] local_addr;

    for(int i=0, bit_no=0; i<SLAVE_ADDRESS_WIDTH; i++) begin 
      // Logic for MSB first or LSB first 
      bit_no = cfg_pkt.msb_first ? ((SLAVE_ADDRESS_WIDTH - 1) - i) : i;

      detect_posedge_scl();
      local_addr[bit_no] = sda_i;
      state = i2c_fsm_state_e'(bit_no+10);
    end

    `uvm_info(name, $sformatf("DEBUG_MSHA :: Value of local_addr = %0x", local_addr), UVM_NONE); 
    `uvm_info(name, $sformatf("DEBUG_MSHA :: Value of slave_address = %0x", cfg_pkt.slave_address), UVM_NONE); 
   
    // Check if the sampled address belongs to this slave
    if(local_addr != cfg_pkt.slave_address) begin
      ack = NEG_ACK;
    end
    else begin
      ack = POS_ACK;
    end
    
    // Sample the Rd/Wr bit
    detect_posedge_scl();
    rd_wr = read_write_e'(sda_i);
    state = RD_WR;

    // Driving the ACK for slave address
    detect_negedge_scl();
    drive_sda(ack); 
    state = SLAVE_ADDR_ACK;

    //detect_posedge_scl();

  endtask: sample_slave_address

  //--------------------------------------------------------------------------------------------
  // Task: sample_data
  //--------------------------------------------------------------------------------------------
  task sample_data(inout i2c_transfer_bits_s data_packet, input i2c_transfer_cfg_s cfg_pkt);
    for(int i=0, bit_no=0; i<REGISTER_ADDRESS_WIDTH; i++) begin 
      // Logic for MSB first or LSB first 
      bit_no = cfg_pkt.msb_first ? ((REGISTER_ADDRESS_WIDTH - 1) - i) : i;

      detect_posedge_scl();
      data_packet.register_address[bit_no] = sda_i;
      state = i2c_fsm_state_e'(bit_no+20);
    end

    `uvm_info(name, $sformatf("DEBUG_MSHA :: Value of register_address = %0x", data_packet.register_address), UVM_NONE); 
   
    // TODO(mshariff): 
    // Check if the sampled register address is accesible by this slave 
    // if(local_addr != cfg_pkt.slave_address) begin
    //   ack = NEG_ACK;
    // end
    // else begin
    //   ack = POS_ACK;
    // end
    
    // Driving the ACK for register address
    detect_negedge_scl();
    `uvm_info(name, $sformatf("DEBUG_MSHA :: Value of data_packet.reg_addr_ack = %0x", data_packet.reg_addr_ack), UVM_NONE); 
    drive_sda(data_packet.reg_addr_ack); 
    state = REG_ADDR_ACK;

    detect_posedge_scl();
      
  endtask: sample_data

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
