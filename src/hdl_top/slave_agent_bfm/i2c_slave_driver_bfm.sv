`ifndef I2C_SLAVE_DRIVER_BFM_INCLUDED_
`define I2C_SLAVE_DRIVER_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class    :i2c_slave_driver_bfm
// Description  : Connects with the HVL driver_proxy for driving the stimulus
//--------------------------------------------------------------------------------------------
import i2c_globals_pkg::*;
interface i2c_slave_driver_bfm(input pclk, 
                               input areset,
                               input scl_i,
                               output reg scl_o,
                               output reg scl_oen,
                               input sda_i,
                               output reg sda_o,
                               output reg sda_oen);
  
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
    $display("Slave Driver BFM");
  end
  
  //-------------------------------------------------------
  // Task: wait_for_system_reset
  // Waiting for system reset to be active
  //-------------------------------------------------------
  // task wait_for_system_reset();
  //   @(negedge areset);
  //   `uvm_info("SLAVE_DRIVER_BFM", $sformatf("System reset detected"), UVM_HIGH);
  //   @(posedge areset);
  //   `uvm_info("SLAVE_DRIVER_BFM", $sformatf("System reset deactivated"), UVM_HIGH);
  // endtask: wait_for_system_reset
  //-------------------------------------------------------
  // Task: wait_for_idle_state
  // Waits for I2C bus to be in IDLe state (SCL=1 and SDA=1)
  //-------------------------------------------------------
  //task wait_for_idle_state();
  //  @(posedge pclk);
  //
  //  while(scl_i!=1 && sda_i!=1) begin
  //    @(posedge pclk);
  //  end
  //    
  //  `uvm_info(name, $sformatf("I2C bus is free state detected"), UVM_HIGH);
  //endtask: wait_for_idle_state
  
  
  
  //task wait_for_start_condition();
  //
  //endtask: wait_for_start_condition
  
`endif
endinterface : i2c_slave_driver_bfm
