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
 
 //The parameter for the data width
 parameter int DATA_LENGTH = 8;
 
 //The parameter for the register address width
 parameter int REGISTER_ADDRESS_WIDTH  = 8;
 
 // The parameter for MAXIMUM_BITS supported per transfer
 parameter int MAXIMUM_BITS = 1024;
 
 // The parameter NO_OF_ROWS specifies the no of rows of an array
 parameter int NO_OF_ROWS  = MAXIMUM_BITS/DATA_LENGTH;
 
 // acknowledge bit or no acknowledge
 parameter bit ack;

 // Enum: slave_address_width_e
 //  
 // Specifies the width of slave address
 //
 // SLAVE_ADDRESS_WIDTH_7 - specifies 7 bit slave address 
 // SLAVE_ADDRESS_WIDTH_10 - specifies 10 bit slave address
 //
 typedef enum bit {
   SLAVE_ADDRESS_WIDTH_7 = 1'b0,
   SLAVE_ADDRESS_WIDTH_10 = 1'b1
 } slave_address_width_e;
 
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
   WRITE = 1'b0,
   READ = 1'b1
 } read_write_e;
 
 // struct: i2c_transfer_char_s
 //
 // sda: array which holds the sda transactions
 // no_of_sda_bits_transfer: specifies how many sda bits to trasnfer 
 //
 typedef struct {
 
   bit[SLAVE_ADDRESS_WIDTH-1:0] slave_address;

   bit[REGISTER_ADDRESS_WIDTH-1:0] register_address;
 
   bit[NO_OF_ROWS-1][DATA_LENGTH-1:0] data;
 
   int no_of_data_bits_transfer; 
 
 } i2c_transfer_data_s;
 
 
 //struct: i2c_transfer_cfg_s
 //read_write : read from or write to slave 
 
 typedef struct {
   bit msb_first;
   bit read_write;
 } i2c_transfer_cfg_s;


endpackage : i2c_globals_pkg 

`endif

