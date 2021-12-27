`ifndef I2C_MASTER_COVERAGE_INCLUDED_
`define I2C_MASTER_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_master_coverage
// i2c_master_coverage determines the how much code is covered for better functionality of the TB.
//--------------------------------------------------------------------------------------------
class i2c_master_coverage extends uvm_subscriber#(i2c_master_tx);
  `uvm_component_utils(i2c_master_coverage)

  // Variable: master_agent_cfg_h
  // Declaring handle for master agent configuration class 
    i2c_master_agent_config i2c_master_agent_cfg_h;
 
  //-------------------------------------------------------
  // Covergroup
  // // TODO(mshariff): Add comments
  // Covergroup consists of the various coverpoints based on the no. of the variables used to improve the coverage.
  //-------------------------------------------------------
  covergroup master_covergroup with function sample (i2c_master_agent_config cfg, i2c_master_tx packet);
    option.per_instance = 1;

    // Mode of the operation
    
    //this coverpoint is to check the slave address width
    SLAVE_ADDRESS_WID_CP : coverpoint cfg.slave_address_array.size()*SLAVE_ADDRESS_WIDTH{
      option.comment = "Width of the the slave address";

      bins SLAVE_ADDRESS_WIDTH_7 = {7};
      bins SLAVE_ADDRESS_WIDTH_10 = {10};
    }
    
    //this coverpoint is to check the slave address width
    SLAVE_ADDRESS_CP : coverpoint packet.slave_address{
      option.comment = " slave address";

      bins SLAVE0_ADDRESS = {7'h68};
      bins SLAVE1_ADDRESS = {7'h6C};
      bins SLAVE2_ADDRESS = {7'h7C};
      bins SLAVE3_ADDRESS = {7'h4C};
    }

    //this coverpoint is to check the slave register address width
    SLAVE_REGISTER_ADDRESS_WID_CP : coverpoint cfg.slave_register_address_array.size()*REGISTER_ADDRESS_WIDTH{
      option.comment = "Width of the the slave register address";

      bins SLAVE_REGISTER_ADDRESS_WIDTH_8 = {8};
    }
    
    //this coverpoint is to check the write data width
 //   WR_DATA_WID_CP : coverpoint packet.wr_data.size()*DATA_WIDTH{
 //     option.comment = "Width of the the slave address";

 //     bins WRITE_DATA_WIDTH_8 = {8};
 //     bins WRITE_DATA_WIDTH_16 = {16};
 //     bins WRITE_DATA_WIDTH_24 = {24};
 //     bins WRITE_DATA_WIDTH_32 = {32};
 //     bins WRITE_DATA_WIDTH_MAX = {[48:MAXIMUM_BITS]};
 //   }
    
 //   //this coverpoint is to check the read data width
 //   RD_DATA_WID_CP : coverpoint packet.rd_data.size()*DATA_WIDTH{
 //     option.comment = "Width of the the slave address";

 //     bins READ_DATA_WIDTH_8 = {8};
 //     bins READ_DATA_WIDTH_16 = {16};
 //     bins READ_DATA_WIDTH_24 = {24};
 //     bins READ_DATA_WIDTH_32 = {32};
 //     bins READ_DATA_WIDTH_MAX = {[48:MAXIMUM_BITS]};
 //   }
    //this coverpoint is to check the operation is read or write 
    OPERATION_READ_WRITE_CP : coverpoint read_write_e'(packet.read_write){
      option.comment = "operation is read or write";

      bins READ = {1};
      bins WRITE = {0};
    }

    //this coverpoint is to check the direction of the data transfer 
    SHIFT_DIRECTION_CP : coverpoint shift_direction_e'(cfg.shift_dir){
      option.comment = "shift_direction of i2c MSB or LSB";

      bins LSB_FIRST = {0};
      bins MSB_FIRST = {1};
    }
    

  //  BAUD_RATE_CP : coverpoint cfg.baudrate_divisior {
  //    option.comment = "it controls the rate of the transfer in the communicaton channel";

  //    bins BAUDRATE_DIVISIOR_2 = {2};
  //    bins BAUDRATE_DIVISIOR_4 = {4};
  //    bins BAUDRATE_DIVISIOR_6 = {6};
  //    bins BAUDRATE_DIVISIOR_ABOVE_8 = {[8:$]};

  //    illegal_bins illegal_bin = {0};
  //  }




  endgroup : master_covergroup

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_master_coverage", uvm_component parent = null);
  extern virtual function void display();
  extern virtual function void write(i2c_master_tx t);
  extern virtual function void report_phase(uvm_phase phase);

endclass : i2c_master_coverage


//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_master_coverage
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i2c_master_coverage::new(string name = "i2c_master_coverage", uvm_component parent = null);
  super.new(name, parent);
  // TODO(mshariff): Create the covergroup
//`uvm_info(get_type_name(),$sformatf(master_cg),UVM_LOW);
//
     master_covergroup = new(); 
//  `uvm_info(get_type_name(),$sformatf(master_cg),UVM_LOW); 
endfunction : new

//--------------------------------------------------------------------------------------------
// Contains the display statements 
//--------------------------------------------------------------------------------------------
function void i2c_master_coverage::display();
  $display("");
  $display("--------------------------------------");
  $display("MASTER COVERAGE");
  $display("--------------------------------------");
  $display("");
endfunction : display

//--------------------------------------------------------------------------------------------
// Function: write
// // TODO(mshariff): Add comments
// sampiling is done
//--------------------------------------------------------------------------------------------
function void i2c_master_coverage::write(i2c_master_tx t);
//  // TODO(mshariff): 
   master_covergroup.sample(i2c_master_agent_cfg_h,t);     
endfunction: write

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Used for reporting the coverage instance percentage values
//--------------------------------------------------------------------------------------------
function void i2c_master_coverage::report_phase(uvm_phase phase);
  display();
  `uvm_info(get_type_name(), $sformatf("Master Agent Coverage = %0.2f %%",master_covergroup.get_coverage()), UVM_NONE);
//  `uvm_info(get_type_name(), $sformatf("Master Agent Coverage") ,UVM_NONE);
endfunction: report_phase
`endif

