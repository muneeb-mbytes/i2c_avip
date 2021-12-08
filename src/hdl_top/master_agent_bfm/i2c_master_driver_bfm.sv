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
                                output scl_o,
                                output scl_oen,
                                input sda_i,
                                output sda_o,
                                output sda_oen
                                //Illegal inout port connection
                                //inout scl,
                                //inout sda);
                              );
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
  
 initial begin
   $display("Master driver BFM");
 end

endinterface : i2c_master_driver_bfm

`endif
