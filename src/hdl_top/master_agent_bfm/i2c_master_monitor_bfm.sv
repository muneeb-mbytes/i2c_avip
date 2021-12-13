`ifndef I2C_MASTER_MONITOR_BFM_INCLUDED_
`define I2C_MASTER_MONITOR_BFM_INCLUDED_

//-------------------------------------------------------
//Module : i2c master Monitor BFM
//Description : connects the master monitor bfm with the monitor proxy
//-------------------------------------------------------
import i2c_globals_pkg::*;
interface i2c_master_monitor_bfm(input pclk, 
                                 input areset, 
                                 input scl_i,
                                 input scl_o,
                                 input scl_oen,
                                 input sda_i,
                                 input sda_o,
                                 input sda_oen
                                 //input scl,
                                 //input sda
                                );
 
 //-------------------------------------------------------
 // Package : Importing Uvm Pakckage and Test Package
 //-------------------------------------------------------
 import uvm_pkg::*;
 `include "uvm_macros.svh"
 
 
 //-------------------------------------------------------
 //Package : Importing I2C Global Package and I2C Master Package
 //-------------------------------------------------------
 import i2c_master_pkg::*;
 import i2c_master_pkg::i2c_master_monitor_proxy;
 
  //Variable : i2c_master_mon_proxy_h
  //Creating the handle for proxy driver
 i2c_master_monitor_proxy i2c_master_mon_proxy_h;

 initial begin
   $display("i2c Master Monitor BFM");
 end
//--------------------------------------------------------------------------------------------
// Task: wait for the system reset 
//--------------------------------------------------------------------------------------------

  task wait_for_reset();
    @(negedge areset);
    `uvm_info("I2C_MASTER_MONITOR_BFM", $sformatf("System reset detected"), UVM_HIGH);
    @(posedge areset);
    `uvm_info("I2C_MASTER_MONITOR_BFM", $sformatf("System reset deactivated"), UVM_HIGH);
  endtask: wait_for_reset

  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for I2C bus to be in IDLe state (SCL=1 and SDA=1)
  //-------------------------------------------------------
  task wait_for_idle_state();
    @(posedge pclk);

    while(scl_i!=1 && sda_i!=1) begin
      @(posedge pclk);
    end
      
    `uvm_info("I2C_MASTER_MONITOR_BFM", $sformatf("I2C bus is free state detected"), UVM_NONE);
  endtask: wait_for_idle_state

endinterface : i2c_master_monitor_bfm

`endif
