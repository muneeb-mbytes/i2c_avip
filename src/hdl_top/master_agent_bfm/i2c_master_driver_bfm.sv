`ifndef I2C_MASTER_DRIVER_BFM_INCLUDED_
`define I2C_MASTER_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
//Interface : i2c_master_driver_bfm
//It connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
import i2c_globals_pkg::*;

interface i2c_master_driver_bfm(input pclk, 
                                input areset,
                                input scl_i,
                                output reg scl_o,
                                output reg scl_oen,
                                input sda_i,
                                output reg sda_o,
                                output reg sda_oen
                                //Illegal inout port connection
                                //inout scl,
                                //inout sda);
                              );
  i2c_fsm_state_e state;
  //-------------------------------------------------------
  // Importing UVM Package 
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  
  //-------------------------------------------------------
  // Importing I2C Global Package and Slave package
  //-------------------------------------------------------
  import i2c_master_pkg::i2c_master_driver_proxy;

  //Variable : master_driver_proxy_h
  //Creating the handle for proxy driver
  i2c_master_driver_proxy i2c_master_drv_proxy_h;
  
  // Variable: name
  // Stores the name for this module
  string name = "I2C_MASTER_DRIVER_BFM";

  // Signals for debugging purpose
  bit start;
  bit stop;
  bit repeated_start;

 initial begin
   $display(name);
 end

  //-------------------------------------------------------
  // Task: wait_for_reset
  // Waiting for system reset to be active
  //-------------------------------------------------------
  task wait_for_reset();
    @(negedge areset);
    `uvm_info(name, $sformatf("System reset detected"), UVM_HIGH);
    @(posedge areset);
    `uvm_info(name, $sformatf("System reset deactivated"), UVM_HIGH);
  endtask: wait_for_reset

  //-------------------------------------------------------
  // Task: drive_idle_state
  // Used for driving SCL=1 and SDA=1
  // TODO(mshariff): Put more comments for logic pf SCL and SDA
  //-------------------------------------------------------
  task drive_idle_state();
    @(posedge pclk);

    scl_oen <= TRISTATE_BUF_OFF;
    scl_o   <= 1;

    sda_oen <= TRISTATE_BUF_OFF;
    sda_o   <= 1;

    `uvm_info(name, $sformatf("Successfully drove the IDLE state"), UVM_HIGH);
  endtask: drive_idle_state

  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for I2C bus to be in IDLe state (SCL=1 and SDA=1)
  //-------------------------------------------------------
  task wait_for_idle_state();
    @(posedge pclk);

    while(scl_i!=1 && sda_i!=1) begin
      @(posedge pclk);
     // state=IDEAL;
    end
      
    `uvm_info(name, $sformatf("I2C bus is free state detected"), UVM_HIGH);
  endtask: wait_for_idle_state

 //-------------------------------------------------------
 // Task: drive_data
 //-------------------------------------------------------
 task drive_data(inout i2c_transfer_bits_s data_packet, 
                 input i2c_transfer_cfg_s cfg_pkt); ;

  // Driving the start condition
  // put it into a task
  @(posedge pclk);
  sda_oen <= TRISTATE_BUF_ON;
  sda_o   <= 0;
  start   <= 1;
  state = START;


  //-------------------------------------------------------
  // 1) Logic for slave_address + Rd/Wr + sampling ACK
  //-------------------------------------------------------

  // a) Driving the slave address
  for(int k=0, bit_no=0; k<SLAVE_ADDRESS_WIDTH; k++) begin
    // Logic for MSB first or LSB first 
    `uvm_info("DEBUG_MSHA", $sformatf("cfg_pkt.msb_first"), UVM_NONE)
    bit_no = cfg_pkt.msb_first ? ((SLAVE_ADDRESS_WIDTH - 1) - k) : k;
    
    @(posedge pclk);
    scl_oen <= TRISTATE_BUF_ON;
    scl_o   <= 0;
    start   <= 0;

    sda_oen <= data_packet.slave_address[bit_no] ? TRISTATE_BUF_OFF : TRISTATE_BUF_ON;
    sda_o   <= data_packet.slave_address[bit_no];
   
    state = i2c_fsm_state_e'(bit_no);
    `uvm_info("DEBUG_MSHA", $sformatf("address = %0b, bit_no = %0d, data = %0b",
            data_packet.slave_address, bit_no, data_packet.slave_address[bit_no]), UVM_NONE)

    @(posedge pclk);
    scl_oen <= TRISTATE_BUF_OFF;
    scl_o   <= 1;
  end

  // b) Driving the Read/write bit
  @(posedge pclk);
  scl_oen <= TRISTATE_BUF_ON;
  scl_o   <= 0;

  sda_oen <= data_packet.read_write ? TRISTATE_BUF_OFF : TRISTATE_BUF_ON;
  sda_o   <= data_packet.read_write;
  state = RD_WR;
  @(posedge pclk);
  scl_oen <= TRISTATE_BUF_OFF;
  scl_o   <= 1;

  // c) Leave the bus free for receiving the ACK from slave
  @(posedge pclk);
  scl_oen <= TRISTATE_BUF_ON;
  scl_o   <= 0;

  sda_oen <= TRISTATE_BUF_OFF;
  sda_o   <= 1;

  @(posedge pclk);
  scl_oen <= TRISTATE_BUF_OFF;
  scl_o   <= 1;
  data_packet.slave_add_ack = sda_i;


  //-------------------------------------------------------
  // 2) Logic for register_address + sampling ACK
  //-------------------------------------------------------

  for(int i=0,bit_no=0;i<REGISTER_ADDRESS_WIDTH ;i++) begin
    `uvm_info("from register address",$sformatf("driving register address"),UVM_NONE);
    bit_no=((REGISTER_ADDRESS_WIDTH -1)-i);
    
    @(posedge pclk);
    scl_oen <= TRISTATE_BUF_ON;
    scl_o   <= 0;
     
    sda_oen <= data_packet.register_address[bit_no] ? TRISTATE_BUF_OFF : TRISTATE_BUF_ON;
    sda_o <= data_packet.register_address[bit_no];
    `uvm_info("Drived register_address on to sda",$sformatf("register_address=%0b,bit_no=%0d, data in register address=%0b",data_packet.register_address,bit_no,data_packet.register_address[bit_no]),UVM_NONE)

    end

    // b) Leave the bus free for receiving the ACK from slave
    @(posedge pclk);
    scl_oen <= TRISTATE_BUF_ON;
    scl_o   <= 0;

    sda_oen <= TRISTATE_BUF_OFF;
    sda_o   <= 1;

    @(posedge pclk);
    scl_oen <= TRISTATE_BUF_OFF;
    scl_o   <= 1;
    data_packet.slave_add_ack = sda_i;


  //-------------------------------------------------------
  // 3) Logic for driving the write_data + sampling ACK
  //-------------------------------------------------------

  //-------------------------------------------------------
  // 4) Logic for sampling the read_data + driving ACK
  //-------------------------------------------------------



  // MSHA: for(int row_no=0; row_no<data_packet.no_of_mosi_bits_transfer/CHAR_LENGTH; row_no++) begin

  // MSHA:   for(int k=0, bit_no=0; k<DATA_WIDTH; k++) begin

  // MSHA:     // Logic for MSB first or LSB first 
  // MSHA:     bit_no = cfg_pkt.msb_first ? ((DATA_WIDTH - 1) - k) : k;

  // MSHA:     data_packet.data[row_no][bit_no]


  // MSHA:   end
  // MSHA: end


    
 endtask: drive_data

endinterface : i2c_master_driver_bfm

`endif
