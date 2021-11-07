//--------------------------------------------------------------------------------------------
//Interface : i2c_master_driver_bfm
//It connects with the HVL driver_proxy for driving the stimulus
//
//parameters :
//intf - i2c interface
//--------------------------------------------------------------------------------------------
interface i2c_master_driver_bfm(i2c_if intf);

//-------------------------------------------------------
//creating the handle for proxy driver
//-------------------------------------------------------
  import i2c_master_pkg::i2c_master_driver_proxy;

  i2c_master_driver_proxy i2c_master_drv_proxy_h;
  
  initial begin
    $display("Master driver BFM");
  end

endinterface : i2c_master_driver_bfm

`endif
