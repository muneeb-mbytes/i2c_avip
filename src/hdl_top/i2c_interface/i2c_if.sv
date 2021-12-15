`ifndef I2C_IF_INCLUDED_
`define I2C_IF_INCLUDED_

//--------------------------------------------------------------------------------------------
// class     : I2C_intf
// Description  : Declaring the signals for i2c interface
//--------------------------------------------------------------------------------------------
//interface i2c_if(input pclk, input areset);
interface i2c_if();
  
  // Variable: scl
  // i2c serial clock signal
  wire scl;
  //wand scl;

  // Variable: sda
  // i2c serial data signal
  wire sda;
  //wand sda;
  
  // module comparatorwithwor(
  //     input x,
  //     input y,
  //     output z
  //     );
  // wor p ;
  //  
  // assign p = x&y;	
  // assign p = ~x & ~y ; 
  //  
  // assign z = p ;
  //  
  // endmodule
  // 
  // 
  // The net p is driven by the outputs of two AND gates as given by the assign statements
  // 
  // assign p = x&y;	
  // assign p = ~x & ~y ;
  // 
  // 
  // However, since p is assigned as wor, the synthesizer inserts an OR gate. 
  // The input to the OR gate is the driver of the two AND gates. 
  //
  // Similar concept for wand

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
  
  // Tri-state buffer implementation 
  assign scl = (scl_oen) ? scl_o : 1'bz;
  assign sda = (sda_oen) ? sda_o : 1'bz;

  // Implementing week0 and week1 concept
  // Logic for Pull-up registers using opne-drain concept
  assign (weak0,weak1) scl = 1'b1;
  assign (weak0,weak1) sda = 1'b1;

  // Used for sampling the I2C interface signals
  assign scl_i = scl;
  assign sda_i = sda;

  //-------------------------------------------------------
  // Example of interfacing with tristate pins:
  // (this will work for any tristate bus)
  //-------------------------------------------------------
  //
  //assign scl_i = scl_pin;
  //assign scl_pin = scl_oen ? scl_o : 1'bz ;
  //assign sda_i = sda_pin;
  //assign sda_pin = sda_oen ? sda_o : 1'bz;

  // Equivalent code that does not use *_oen connections:
  // (we can get away with this because I2C is open-drain)
  //
  //assign scl_i = scl_pin;
  //assign scl_pin = scl_o ? 1'bz : 1'b0;
  //assign sda_i = sda_pin;
  //assign sda_pin = sda_o ? 1'bz : 1'b0;

  // Example of two interconnected I2C devices:
  //
  //assign scl_1_i = scl_1_o & scl_2_o;
  //assign scl_2_i = scl_1_o & scl_2_o;
  //assign sda_1_i = sda_1_o & sda_2_o;
  //assign sda_2_i = sda_1_o & sda_2_o;

  // Example of two I2C devices sharing the same pins:
  //
  //assign scl_1_i = scl_pin;
  //assign scl_2_i = scl_pin;
  //assign scl_pin = (scl_1_o & scl_2_o) ? 1'bz : 1'b0;
  //assign sda_1_i = sda_pin;
  //assign sda_2_i = sda_pin;
  //assign sda_pin = (sda_1_o & sda_2_o) ? 1'bz : 1'b0;

  // Notes:
  // scl_o should not be connected directly to scl_i, only via AND logic or a tristate
  // I/O pin.  This would prevent devices from stretching the clock period.

endinterface : i2c_if

`endif
