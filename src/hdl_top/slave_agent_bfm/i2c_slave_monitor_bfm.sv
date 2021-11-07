`ifndef I2C_SLAVE_MONITOR_BFM_INCLUDED_
`define I2C_SLAVE_MONITOR_BFM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class    : I2C Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

interface i2c_slave_monitor_bfm(i2c_if intf);
  
  initial begin
    //`uvm_info("-----",(Slave Monitor BFM"),UVM_LOW);
    $display("Slave Monitor BFM");
  end

endinterface : i2c_slave_monitor_bfm


`endif
