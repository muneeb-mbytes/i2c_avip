  `ifdef HDL_TOP INCLUDED_
  `define HDL_TOP_INCLUDED_
//--------------------------------------------------------------------------------------------
// module : hdl_top
// Description : hdl top has a interface and master and slave agent bfm
//--------------------------------------------------------------------------------------------
module hdl_top;
import uvm_pkg::*;
`include "uvm_macros.svh"

//-------------------------------------------------------
//Clock  Initialization 
//-------------------------------------------------------
// bit scl;
//-------------------------------------------------------
// Display statement for HDL_TOP
//-------------------------------------------------------

  initial begin
   `uvm_info("UVM_INFO","HDL_TOP",UVM_LOW);
  $display("HDL TOP");
  end

//-------------------------------------------------------
//I2C Interface Instantiation
//
//-------------------------------------------------------

  i2c_if intf();

//-------------------------------------------------------
// i2c Master BFM Agent Instantiation
//-------------------------------------------------------
  i2c_master_agent_bfm i2c_master_agent_bfm_h(intf); 

//-------------------------------------------------------
//i2c Slave BFM Agent Instantiation
//-------------------------------------------------------
  i2c_slave_agent_bfm i2c_slave_agent_bfm_h(intf);

endmodule : hdl_top

`endif
