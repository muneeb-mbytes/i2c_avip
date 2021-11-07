`ifndef I2C_GLOBALS_PKG_INCLUDED_
`define I2C_GLOBALS_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// global pkg for all variables 
//--------------------------------------------------------------------------------------------

package i2c_globals_pkg;

// NO_OF_SLAVES to be connected to the spi_interface

parameter int NO_OF_MASTERS = 1;
parameter int NO_OF_SLAVES = 1;

endpackage : i2c_globals_pkg 

`endif

