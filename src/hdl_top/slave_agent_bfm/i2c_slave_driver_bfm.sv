`ifndef I2C_SLAVE_DRIVER_BFM_INCLUDED_
`define I2C_SLAVE_DRIVER_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class    :i2c_slave_driver_bfm
// Description  : Connects with the HVL driver_proxy for driving the stimulus
//
// parameters :
// intf -i2c interface
//--------------------------------------------------------------------------------------------
interface i2c_slave_driver_bfm(i2c_if intf);

  initial begin
  //`uvm_info("------,(slave driver bfm"),UVM_LOW);
    $display("Slave Driver BFM");
  end

endinterface : i2c_slave_driver_bfm

`endif
