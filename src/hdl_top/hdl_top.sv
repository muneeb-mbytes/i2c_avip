`ifndef HDL_TOP_INCLUDED_
`define HDL_TOP_INCLUDED_
//--------------------------------------------------------------------------------------------
// module : hdl_top
// Description : hdl top has a interface and master and slave agent bfm
//--------------------------------------------------------------------------------------------
module hdl_top;

  import i2c_globals_pkg::*;

  //-------------------------------------------------------
  // Clock Reset Initialization
  //-------------------------------------------------------
  bit clk;
  bit rst;
 
  wire SCL;
  //wand SDA;
  wire SDA;

  //-------------------------------------------------------
  // Display statement for HDL_TOP
  //-------------------------------------------------------
  initial begin
  $display("HDL TOP");
  end
 
  //-------------------------------------------------------
  // System Clock Generation
  //-------------------------------------------------------
  initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
  end
 
  //-------------------------------------------------------
  // System Reset Generation
  // Active low reset
  //-------------------------------------------------------
  initial begin
    rst = 1'b1;
 
    repeat (2) begin
      @(posedge clk);
    end
    rst = 1'b0;
 
    repeat (2) begin
      @(posedge clk);
    end
    rst = 1'b1;
  end
 
  // Variable : i2c_intf
  // I2C Interface Instantiation
  //i2c_if i2c_intf (.pclk(clk),
  //                 .areset(rst));
 
   i2c_if i2c_intf();
  //
  //i2c_if i2c_intf_master0 ();
  //i2c_if i2c_intf_slave0 ();

  // TODO(mshariff): Modifiy the code for multiple masters             
  //
  // Variable : master_agent_bfm_h
  // I2c Master BFM Agent Instantiation 
  i2c_master_agent_bfm #(.MASTER_ID(0)) i2c_master_agent_bfm_h(.pclk(clk), .areset(rst), .intf(i2c_intf));
                                              //.scl_i(i2c_intf.SCL),
                                              //.sda_i(i2c_intf.SDA)); 

  i2c_slave_agent_bfm #(.SLAVE_ID(0)) i2c_slave_agent_bfm_h_0 (.pclk(clk), .areset(rst), .intf(i2c_intf));

  //assign i2c_master_agent_bfm_h.intf.scl_i  = SCL;
  //assign i2c_slave_agent_bfm_h_0.intf.scl_i = SCL;
  ////assign SCL = (i2c_master_agent_bfm_h.intf.scl & i2c_slave_agent_bfm_h_0.intf.scl) ? 1'bz : 1'b0;
  ////assign SCL = (i2c_master_agent_bfm_h.intf.scl_o & i2c_slave_agent_bfm_h_0.intf.scl_o) ? 1'bz : 1'b0;
  //// assign SCL = (i2c_master_agent_bfm_h.intf.scl_o & i2c_slave_agent_bfm_h_0.intf.scl_o) ? 1'b1 : 1'b0;
  ////assign SCL = i2c_master_agent_bfm_h.intf.scl_o ? 1'bz : 1'b0;
  //assign SCL = i2c_master_agent_bfm_h.intf.scl_oen ? i2c_master_agent_bfm_h.intf.scl_o : 1'bz;

  //assign i2c_master_agent_bfm_h.intf.sda_i  = SDA;
  //assign i2c_slave_agent_bfm_h_0.intf.sda_i = SDA;
  ////assign SDA = (i2c_master_agent_bfm_h.intf.sda & i2c_slave_agent_bfm_h_0.intf.sda) ? 1'bz : 1'b0;
  ////assign SDA = (i2c_master_agent_bfm_h.intf.sda_o & i2c_slave_agent_bfm_h_0.intf.sda_o) ? 1'bz : 1'b0;
  //// assign SDA = (i2c_master_agent_bfm_h.intf.sda_o & i2c_slave_agent_bfm_h_0.intf.sda_o) ? 1'bz : 1'b0;
  //assign SDA = i2c_master_agent_bfm_h.intf.sda_oen ? i2c_master_agent_bfm_h.intf.sda_o :
  //             (i2c_slave_agent_bfm_h_0.intf.sda_oen ? i2c_slave_agent_bfm_h_0.intf.sda_o : 1'bz);

  //// Implementing week0 and week1 concept
  //// Logic for Pull-up registers using opne-drain concept
  //assign (weak0,weak1) SCL = 1'b1;
  //assign (weak0,weak1) SDA = 1'b1;

  // MSHA: assign SCL = i2c_intf_master0.scl; 
  // MSHA: assign i2c_intf_master0.scl_i = SCL;

  // MSHA: assign SDA = i2c_intf_master0.sda; 
  // MSHA: assign i2c_intf_master0.sda_i = SDA;

  // MSHA: assign SCL = i2c_intf_slave0.scl; 
  // MSHA: assign i2c_intf_slave0.scl_i = SCL;
  // MSHA: 
  // MSHA: assign SDA = i2c_intf_slave0.sda; 
  // MSHA: assign i2c_intf_slave0.sda_i = SDA;


  // MSHA: // Variable : slave_agent_bfm_h
  // MSHA: // I2C Slave BFM Agent Instantiation
  // MSHA: i2c_slave_agent_bfm #(.SLAVE_ID(0)) i2c_slave_agent_bfm_h_0 (.pclk(clk), .areset(rst), .intf(i2c_intf_slave0));
  // MSHA: i2c_slave_agent_bfm #(.SLAVE_ID(1)) i2c_slave_agent_bfm_h_1 (.pclk(clk), .areset(rst), .intf(i2c_intf_slave1));
  // MSHA: i2c_slave_agent_bfm #(.SLAVE_ID(2)) i2c_slave_agent_bfm_h_2 (.pclk(clk), .areset(rst), .intf(i2c_intf_slave2));
  // MSHA: i2c_slave_agent_bfm #(.SLAVE_ID(3)) i2c_slave_agent_bfm_h_3 (.pclk(clk), .areset(rst), .intf(i2c_intf_slave3));

  // MSHA: // Connections
  // MSHA: assign i2c_intf_master0.scl_i = SCL; 
  // MSHA: assign i2c_intf_slave0.scl_i  = SCL; 
  // MSHA: assign i2c_intf_slave1.scl_i  = SCL; 
  // MSHA: assign i2c_intf_slave2.scl_i  = SCL; 
  // MSHA: assign i2c_intf_slave3.scl_i  = SCL; 

  // MSHA: assign i2c_intf_master0.sda_i = SDA; 
  // MSHA: assign i2c_intf_slave0.sda_i  = SDA; 
  // MSHA: assign i2c_intf_slave1.sda_i  = SDA; 
  // MSHA: assign i2c_intf_slave2.sda_i  = SDA; 
  // MSHA: assign i2c_intf_slave3.sda_i  = SDA; 

  // MSHA: assign SCL = i2c_intf_master0.scl; 

  // MSHA: assign SDA = i2c_intf_master0.sda;
  // MSHA: assign SDA = i2c_intf_slave0.sda;
  // MSHA: assign SDA = i2c_intf_slave1.sda;
  // MSHA: assign SDA = i2c_intf_slave2.sda;
  // MSHA: assign SDA = i2c_intf_slave3.sda;


  // MSHA: generate
  // MSHA:   for (genvar i=0; i < NO_OF_SLAVES; i++) begin : I2C_SLAVE_AGENT_BFM
  // MSHA:     i2c_slave_agent_bfm #(.SLAVE_ID(i)) i2c_slave_agent_bfm_h(.pclk(clk), .areset(rst), .intf(i2c_intf));
  // MSHA:     //i2c_slave_agent_bfm #(.SLAVE_ID(i)) i2c_slave_agent_bfm_h(i2c_intf);
  // MSHA:     //assign I2C_SLAVE_AGENT_BFM.i2c_slave_agent_bfm_h.intf.
  // MSHA:   end
  // MSHA: endgenerate

  // MSHA: //-------------------------------------------------------
  // MSHA: // Connecting various devices to I2C interface
  // MSHA: //-------------------------------------------------------

  // MSHA: // Master connections
  // MSHA: assign i2c_master_agent_bfm_h.scl_i = i2c_intf.SCL;
  // MSHA: assign i2c_master_agent_bfm_h.sda_i = i2c_intf.SDA;

  // MSHA: // Interface connections
  // MSHA: // Tri-state buffer implementation 
  // MSHA: assign i2c_intf.SCL = i2c_master_agent_bfm_h.scl_oen ? 1'bz : i2c_master_agent_bfm_h.scl_o;

  // MSHA: // Slave connections
  // MSHA: generate
  // MSHA:   for (genvar i=0; i < NO_OF_SLAVES; i++) begin : I2C_SLAVE_AGENT_BFM_CONNECTION
  // MSHA:     // SCL
  // MSHA:     assign i2c_intf.SCL = I2C_SLAVE_AGENT_BFM[i].i2c_slave_agent_bfm_h.scl_oen ? 
  // MSHA:                           1'bz : 
  // MSHA:                           I2C_SLAVE_AGENT_BFM[i].i2c_slave_agent_bfm_h.scl_o;

  // MSHA:     assign I2C_SLAVE_AGENT_BFM[i].i2c_slave_agent_bfm_h.scl_i = i2c_intf.SCL;                          

  // MSHA:     // SDA
  // MSHA:     assign i2c_intf.SDA = I2C_SLAVE_AGENT_BFM[i].i2c_slave_agent_bfm_h.sda_oen ? 
  // MSHA:                           1'bz : 
  // MSHA:                           I2C_SLAVE_AGENT_BFM[i].i2c_slave_agent_bfm_h.sda_o;

  // MSHA:     assign I2C_SLAVE_AGENT_BFM[i].i2c_slave_agent_bfm_h.sda_i = i2c_intf.SDA;                          
  // MSHA:   end
  // MSHA: endgenerate

  // MSHA: // Implementing week0 and week1 concept
  // MSHA: // Logic for Pull-up registers using opne-drain concept
  // MSHA: assign (weak0,weak1) i2c_intf.SCL = 1'b1;
  // MSHA: assign (weak0,weak1) i2c_intf.SDA = 1'b1;


endmodule : hdl_top

`endif
