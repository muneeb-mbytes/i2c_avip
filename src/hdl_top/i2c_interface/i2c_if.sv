`ifndef I2C_IF_INCLUDED_
`define I2C_IF_INCLUDED_

//--------------------------------------------------------------------------------------------
// class     : I2C_intf
// Description  : Declaring the signals for i2c interface
//--------------------------------------------------------------------------------------------
interface i2c_if(input pclk, input areset);
  
  // Variable: scl
  // i2c serial clock signal
  logic scl;

  // Variable: sda
  // i2c serial data signal
  logic sda;
  
  // Variable: scl_i
  // i2c serial input clocl signal
  logic scl_i;
	
  // Variable: scl_o
  // i2c serial output clock signal
  logic scl_o;
	
  // Variable: scl_oen
  // i2c serial output enable signal
  logic scl_oen;
  
  // Variable: sda_i
  // i2c serial input data signal
  logic  sda_i;
  
  // Variable: sda_o
  // i2c serial output data signal
	logic sda_o;
  
  // Variable: sda_oen
  // i2c serial output enable signal
	logic sda_oen; 
  
  // Implementing week0 and week1 concept
 // assign scl=(scl_oen) ? scl_o:1'bz;
 // assign (weak0,weak1)scl=1'b1;
 // assign scl_i = scl;

 // assign sda=(sda_oen) ? sda_o:1'bz;
 // assign (weak0,weak1)sda=1'b1;
 // assign sda_i = sda;


endinterface : i2c_if

`endif
