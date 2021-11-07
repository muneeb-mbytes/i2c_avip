//-------------------------------------------------------
//Module : i2c master Monitor BFM
//Description : connects the master monitor bfm with the monitor proxy
//-------------------------------------------------------
module i2c_master_monitor_bfm(i2c_if intf);
 
  //-------------------------------------------------------
  //creating the handle for proxy monitor
  //-------------------------------------------------------
  import i2c_master_pkg::i2c_master_monitor_proxy;
  i2c_ master_monitor_proxy i2c_master_mon_proxy_h;

  initial begin
    $display("i2c Master Monitor BFM");
  end

endmodule : i2c_master_monitor_bfm

