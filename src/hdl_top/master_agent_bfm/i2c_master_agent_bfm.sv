`ifndef I2C_MASTER_AGENT_BFM_INCLUDED_
`define I2C_MASTER_AGENT_BFM_INCLUDED_

//-------------------------------------------------------
//module : i2c_master_agent_bfm
//Description : Instaniate driver and monitor
//
//-------------------------------------------------------
module i2c_master_agent_bfm(i2c_if intf);

   initial  begin
      $display("I2C Master Agent BFM");
   end
//-------------------------------------------------------
//master driver bfm instantiation
//-------------------------------------------------------
   i2c_master_driver_bfm i2c_master_drv_bfm_h(intf);

//-------------------------------------------------------
//master monitor bfm instatiation
//-------------------------------------------------------
   
   i2c_master_monitor_bfm i2c_master_mon_bfm_h(intf);

endmodule : i2c_master_agent_bfm

`endif
