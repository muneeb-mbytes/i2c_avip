`ifndef I2CSLAVE_AGENT_BFM_INCLUDED_
`define I2C_SLAVE_AGENT_BFM_INCLUDED_

module i2c_slave_agent_bfm(i2c_if intf);
  
  initial begin
    $display("Slave Agent BFM");
  end

  //-------------------------------------------------------
  //I2C Slave driver bfm instantiation
  //-------------------------------------------------------
  i2c_slave_driver_bfm i2c_slave_drv_bfm_h(intf);

  //-------------------------------------------------------
  //I2CSlave driver bfm instantiation
  //-------------------------------------------------------
  i2c_slave_monitor_bfm i2c_slave_mon_bfm_h(intf);

endmodule : i2c_slave_agent_bfm

`endif
