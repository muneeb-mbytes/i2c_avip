onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdl_top/intf/pclk
add wave -noupdate /hdl_top/intf/areset
add wave -noupdate -divider {New Divider}
add wave -noupdate /hdl_top/intf/scl_oen
add wave -noupdate /hdl_top/intf/scl_o
add wave -noupdate /hdl_top/intf/scl
add wave -noupdate /hdl_top/intf/scl_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /hdl_top/intf/sda_oen
add wave -noupdate /hdl_top/intf/sda_o
add wave -noupdate /hdl_top/intf/sda
add wave -noupdate /hdl_top/intf/sda_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /hdl_top/intf/scl
add wave -noupdate /hdl_top/intf/sda
add wave -noupdate /hdl_top/i2c_master_agent_bfm_h/i2c_master_drv_bfm_h/start
add wave -noupdate /hdl_top/i2c_master_agent_bfm_h/i2c_master_drv_bfm_h/stop
add wave -noupdate /hdl_top/i2c_master_agent_bfm_h/i2c_master_drv_bfm_h/repeated_start
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {90 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {608 ns}
