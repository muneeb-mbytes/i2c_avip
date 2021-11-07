module i2c_hvl_top;

  import i2c_test_pkg::*;
  import uvm_pkg::*;


  initial
  begin
    run_test("i2c_base_test");
  end

endmodule : i2c_hvl_top
