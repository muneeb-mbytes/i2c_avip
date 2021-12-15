`ifndef I2C_MASTER_AGENT_BFM_INCLUDED_
`define I2C_MASTER_AGENT_BFM_INCLUDED_

//-------------------------------------------------------
//module : i2c_master_agent_bfm
//Description : Instaniate driver and monitor
//
//-------------------------------------------------------
module i2c_master_agent_bfm#(parameter int MASTER_ID=0)
                              (input pclk, 
                               input areset,
                               i2c_if intf);
//module i2c_master_agent_bfm #(parameter int MASTER_ID=0)
//                             (input pclk, 
//                              input areset,
//                              input scl_i,
//                              output reg scl_o,
//                              output reg scl_oen,
//                              input sda_i,
//                              output reg sda_o,
//                              output reg sda_oen);

 //-------------------------------------------------------
 // Package : Importing Uvm Pakckage and Test Package
 //-------------------------------------------------------
 import uvm_pkg::*;
 `include "uvm_macros.svh"

  //-------------------------------------------------------
  // Package : Importing SPI Global Package 
  //-------------------------------------------------------
  import i2c_globals_pkg::*;

 //-------------------------------------------------------
 //master driver bfm instantiation
 //-------------------------------------------------------
 i2c_master_driver_bfm i2c_master_drv_bfm_h(.pclk(pclk), 
                                            .areset(areset),
                                            .scl_i(intf.scl_i),
                                            .scl_o(intf.scl_o),
                                            .scl_oen(intf.scl_oen),
                                            .sda_i(intf.sda_i),
                                            .sda_o(intf.sda_o),
                                            .sda_oen(intf.sda_oen)
                                           );

 //-------------------------------------------------------
 //master monitor bfm instatiation
 //-------------------------------------------------------
 i2c_master_monitor_bfm i2c_master_mon_bfm_h(.pclk(pclk), 
                                            .areset(areset),
                                            .scl_i(intf.scl_i),
                                            .scl_o(intf.scl_o),
                                            .scl_oen(intf.scl_oen),
                                            .sda_i(intf.sda_i),
                                            .sda_o(intf.sda_o),
                                            .sda_oen(intf.sda_oen)
                                            );

 //-------------------------------------------------------
 // Setting the virtual handle of BMFs into config_db
 //-------------------------------------------------------
 
 initial begin
  uvm_config_db#(virtual i2c_master_driver_bfm)::set(null,"*","i2c_master_driver_bfm",
                                                              i2c_master_drv_bfm_h);

  uvm_config_db#(virtual i2c_master_monitor_bfm)::set(null,"*","i2c_master_monitor_bfm",
                                                              i2c_master_mon_bfm_h);
  end

 initial begin
   $display("Master Agent BFM");
 end

endmodule : i2c_master_agent_bfm

`endif
