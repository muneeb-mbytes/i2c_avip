`ifndef I2C_SLAVE_AGENT_BFM_INCLUDED_
`define I2C_SLAVE_AGENT_BFM_INCLUDED_

module i2c_slave_agent_bfm #(parameter int SLAVE_ID=0) 
                              (input pclk, 
                               input areset,
                               i2c_if intf);
//module i2c_slave_agent_bfm #(parameter int SLAVE_ID=0)
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
  //-------------------------------------------------------
  //I2C Slave driver bfm instantiation
  //-------------------------------------------------------
  i2c_slave_driver_bfm i2c_slave_drv_bfm_h(.pclk(pclk), 
                                           .areset(areset),
                                           .scl_i(intf.scl_i),
                                           .scl_o(intf.scl_o),
                                           .scl_oen(intf.scl_oen),
                                           .sda_i(intf.sda_i),
                                           .sda_o(intf.sda_o),
                                           .sda_oen(intf.sda_oen)//.scl(intf.scl),
                                           //.sda(intf.sda)
                                          );
  // MSHA: assign i2c_slave_drv_bfm_h.slave_id = SLAVE_ID;

  //-------------------------------------------------------
  //I2C slave driver bfm instantiation
  //-------------------------------------------------------
  i2c_slave_monitor_bfm i2c_slave_mon_bfm_h(.pclk(pclk), 
                                            .areset(areset),
                                            .scl_i(intf.scl_i),
                                            .scl_o(intf.scl_o),
                                            .scl_oen(intf.scl_oen),
                                            .sda_i(intf.sda_i),
                                            .sda_o(intf.sda_o),
                                            .sda_oen(intf.sda_oen)
                                          );
  // MSHA: assign i2c_slave_mon_bfm_h.slave_id = SLAVE_ID;
 //-------------------------------------------------------
 // Setting the virtual handle of BMFs into config_db
 //-------------------------------------------------------
 
 initial begin
  // MSHA: static string path_drv, path_mon;
  
  // MSHA: path_drv = {"*i2c_slave_driver_bfm*",$sformatf("%0d",SLAVE_ID),"*"};
  // MSHA: $display("DEBUG_MSHA :: path_drv = %0s", path_drv);

  // MSHA: path_mon = {"*i2c_slave_monitor_bfm*",$sformatf("%0d",SLAVE_ID),"*"};
  // MSHA: $display("DEBUG_MSHA :: path_mon = %0s", path_mon);

  // MSHA: uvm_config_db#(virtual i2c_slave_driver_bfm)::set(null,path_drv,"i2c_slave_driver_bfm",
  // MSHA:                                                             i2c_slave_drv_bfm_h);

  // MSHA: uvm_config_db#(virtual i2c_slave_monitor_bfm)::set(null,path_mon,"i2c_slave_monitor_bfm",
  // MSHA:                                                             i2c_slave_mon_bfm_h);

  static string drv_str, mon_str;
  drv_str = {"i2c_slave_driver_bfm_",$sformatf("%0d",SLAVE_ID)};
  $display("DEBUG_MSHA :: drv_str = %0s", drv_str);

  mon_str = {"i2c_slave_monitor_bfm_",$sformatf("%0d",SLAVE_ID)};
  $display("DEBUG_MSHA :: mon_str = %0s", mon_str);

  uvm_config_db#(virtual i2c_slave_driver_bfm)::set(null,"*",drv_str,
                                                              i2c_slave_drv_bfm_h);

  uvm_config_db#(virtual i2c_slave_monitor_bfm)::set(null,"*",mon_str,
                                                              i2c_slave_mon_bfm_h);
  end

  initial begin
    $display("Slave Agent BFM");
  end


endmodule : i2c_slave_agent_bfm

`endif
