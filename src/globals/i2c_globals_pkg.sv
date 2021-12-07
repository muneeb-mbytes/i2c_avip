`ifndef I2C_GLOBALS_PKG_INCLUDED_
`define I2C_GLOBALS_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// global pkg for all variables 
//--------------------------------------------------------------------------------------------

package i2c_globals_pkg;

 // NO_OF_SLAVES to be connected to the i2c_interface
 parameter int NO_OF_MASTERS = 1;
 
 // NO_OF_MASTERS to be connected to the i2c_interface
 parameter int NO_OF_SLAVES = 1;
 
 // The parameter NO_OF_REG is to assign number of registers in a slave
 parameter int NO_OF_REG = 1;
 
 // The parameter for the data width
 parameter int DATA_WIDTH = 8;
 
 // The parameter for the register address width
// parameter int SLAVE_ADDRESS_WIDTH  = 10;
 
// The parameter for the slave address width
 parameter int SLAVE_ADDRESS_WIDTH  = 7;
 
 // The parameter for the register address width
 parameter int REGISTER_ADDRESS_WIDTH  = 8;
 
 // The parameter for MAXIMUM_BITS supported per transfer
 parameter int MAXIMUM_BITS = 1024;

 // The parameter for MAXIMUM_BYTES supported per transfer
 parameter int MAXIMUM_BYTES = MAXIMUM_BITS/DATA_WIDTH ;
 
  // Slave addresses
  parameter SLAVE0_ADDRESS = 7'b110_1000;
  parameter SLAVE1_ADDRESS = 7'b110_1100;
  parameter SLAVE2_ADDRESS = 7'b111_1100;
  parameter SLAVE3_ADDRESS = 7'b100_1100;

 // acknowledge bit or no acknowledge
 // parameter bit ACK = 0;
 // parameter bit NACK = 1;

 // Enum: slave_address_e
 //  
 // Specifies the width of slave address
 //
 // SLAVE_ADDRESS_7 - specifies 7 bit slave address 
 // SLAVE_ADDRESS_10 - specifies 10 bit slave address
 //
// typedef enum bit [3:0] {
//
//   SLAVE_ADDRESS_7 = 7,
//   SLAVE_ADDRESS_10 = 10
//     
// } slave_address_e;

 // Enum: shift_direction_e
 // 
 // Specifies the shift direction
 //
 // LSB_FIRST - LSB is shifted out first
 // MSB_FIRST - MSB is shifted out first
 //
 typedef enum bit {
   MSB_FIRST = 1'b1,
   LSB_FIRST = 1'b0
 } shift_direction_e;
 
 
 // Enum: read_write_e
 // 
 // Specifies the read or write request
 // READ - READ request 
 // WRITE - WRITE request
 //
 typedef enum bit {
   WRITE = 1'b0,
   READ = 1'b1
 } read_write_e;
 
 // struct: i2c_bits_transfer_s
 //
 // sda: array which holds the sda transactions
 // no_of_sda_bits_transfer: specifies how many sda bits to trasnfer 
 //

 typedef struct {
  // bit[SLAVE_ADDRESS_WIDTH-1:0]slave_address;
   bit[REGISTER_ADDRESS_WIDTH-1:0]register_address;
 
   bit[MAXIMUM_BYTES-1][DATA_WIDTH-1:0] data;
   int no_of_register_address_bits_transfer; 
  } i2c_register_address_s;

 
 // struct: i2c_transfer_cfg_s
 // read_write : read from or write to slave 
 
 typedef struct {
   bit msb_first;
   bit read_write;
 } i2c_transfer_cfg_s;


endpackage : i2c_globals_pkg 

`endif

