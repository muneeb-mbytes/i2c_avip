`ifndef I2C_SLAVE_MONITOR_BFM_INCLUDED_
`define I2C_SLAVE_MONITOR_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class    : I2C Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

interface i2c_slave_monitor_bfm(input pclk, 
                                input areset, 
                                input scl_i,
                                input scl_o,
                                input scl_oen,
                                input sda_i,
                                input sda_o,
                                input sda_oen);
  int slave_id;

 //-------------------------------------------------------
 // Package : Importing Uvm Pakckage and Test Package
 //-------------------------------------------------------
 import uvm_pkg::*;
 `include "uvm_macros.svh"
 
  //-------------------------------------------------------
 //Package : Importing I2C Global Package and I2C slave Package
 //-------------------------------------------------------
 import i2c_slave_pkg::*;
 import i2c_slave_pkg::i2c_slave_monitor_proxy;
 
  //Variable : i2c_slave_mon_proxy_h
  //Creating the handle for proxy driver
 i2c_slave_monitor_proxy i2c_slave_mon_proxy_h; 
  initial begin
    $display("Slave Monitor BFM");
  end

 //-------------------------------------------------------
 // Task : wait_for_system_reset
 // Wait for system reset
 //-------------------------------------------------------
 //task wait_for_system_reset();
 //  @(negedge areset);
 //  `uvm_info(name, $sformatf("System reset detected"), UVM_HIGH);
 //  @(posedge areset);
 //  `uvm_info(name , $sformatf("System reset deactivated"), UVM_HIGH);
 //endtask: wait_for_system_reset

 ////-------------------------------------------------------
 //// Task : wait_for_system_reset
 //// Wait for system reset
 ////-------------------------------------------------------
 //task wait_for_idle_state();
 // @(posedge pclk);
 //
 // while(scl_i!=1 && sda_i!=1) begin
 //   @(posedge pclk);
 // end
 //   
 // `uvm_info(name, $sformatf("I2C bus is free state detected"), UVM_HIGH);
 //endtask: wait_for_idle_state
  


endinterface : i2c_slave_monitor_bfm


`endif
