`ifndef I2C_8B_VIRTUAL_SEQ_INCLUDED_
`define I2C_8B_VIRTUAL_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i2c_8b_virtual_seq
// <Description_here>
//--------------------------------------------------------------------------------------------
class i2c_8b_virtual_seq extends i2c_virtual_base_seq;
  `uvm_object_utils(i2c_8b_virtual_seq)
  
  i2c_8b_master_seq i2c_8b_master_seq_h;
  i2c_8b_slave_seq  i2c_8b_slave_seq_h;
 
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i2c_8b_virtual_seq");
  extern task body();

endclass : i2c_8b_virtual_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i2c_8b_virtual_seq
//--------------------------------------------------------------------------------------------
function i2c_8b_virtual_seq::new(string name = "i2c_8b_virtual_seq");
  super.new(name);
endfunction : new

//-------------------------------------------------------
//task : body
//
//-------------------------------------------------------

task i2c_8b_virtual_seq::body();
  super.body(); //Sets up the sub-sequencer pointer

  //crearions master and slave sequence handles here  
  i2c_8b_master_seq_h=i2c_8b_master_seq::type_id::create("i2c_8b_master_seq_h");

  //-------------------------------------------------------
  // Starting slave sequences in parallel and
  // each slave sequence must be running forever and respond to 
  // master's request
  //-------------------------------------------------------
  for(int i=0; i<NO_OF_SLAVES ; i++) begin : SLAVES_SEQ_START
     automatic int id=i;
     fork
       begin
         forever begin
            i2c_8b_slave_seq_h=i2c_8b_slave_seq::type_id::create($sformatf("i2c_8b_slave_seq_h[%0d]",id));
            i2c_8b_slave_seq_h.start(p_sequencer.i2c_slave_seqr_h[id]);
          end
       end
     join_none
  end

  //-------------------------------------------------------
  // Starting the master sequences
  //-------------------------------------------------------
  repeat(1) begin : MASTER_WR_SEQ_START
    i2c_8b_master_seq_h.start(p_sequencer.i2c_master_seqr_h[0]);
  end

  repeat(1) begin : MASTER_RD_SEQ_START
    i2c_8b_master_seq_h.start(p_sequencer.i2c_master_seqr_h[0]);
  end

endtask: body

`endif

