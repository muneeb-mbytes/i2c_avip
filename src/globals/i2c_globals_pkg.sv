`ifndef I2C_GLOBALS_PKG_INCLUDED_
`define I2C_GLOBALS_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// global pkg for all variables 
//--------------------------------------------------------------------------------------------

package i2c_globals_pkg;

// NO_OF_SLAVES to be connected to the i2c_interface

parameter int NO_OF_MASTERS = 1;
parameter int NO_OF_SLAVES = 1;


parameter int DATA_LENGTH = 8;

//The parameter for the slave address 
parameter int SLAVE_ADDRESS  = 8;


//The parameter for the register address 
parameter int REGISTER_ADDRESS  = 8;
parameter int MAX_BITS = 1024;
parameter int NO_OF_ROWS  = MAX_BITS/DATA_LENGTH;

// Enum: shift_direction_e
// 
// Specifies the shift direction
//
// LSB_FIRST - LSB is shifted out first
// MSB_FIRST - MSB is shifted out first
//
typedef enum bit {
  LSB_FIRST = 1'b0,
  MSB_FIRST = 1'b1
} shift_direction_e;


// Enum: read_write_e
// 
// Specifies the read or write request
// READ - READ request 
// WRITE - WRITE request
//
typedef enum bit {
  READ = 1'b1,
  WRITE = 1'b0
} read_write_e;

// struct: i2c_transfer_char_s
//
// sda: array which holds the sda transactions
// no_of_sda_bits_transfer: specifies how many sda bits to trasnfer 
//
typedef struct {

  bit[SLAVE_ADDRESS-1:0] slave_addr;
  bit[REGISTER_ADDRESS-1:0]register_address;

  bit[NO_OF_ROWS-1][DATA_LENGTH-1:0] data;

  int no_of_data_bits_transfer; 

} i2c_transfer_data_s;


//struct: i2c_transfer_cfg_s
//read : read for the reading purpose
//write : write on the slave the slave

typedef struct {
  
  bit msb_first;
  bit read;
  bit write;
} i2c_transfer_cfg_s;


endpackage : i2c_globals_pkg 

`endif

