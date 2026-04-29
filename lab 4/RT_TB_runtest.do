SetActiveLib -work
comp -include "$dsn\src\k16_rom.vhd"
comp -include "$dsn\src\SR_transmitter.vhd"
comp -include "$dsn\src\SR_receiver.vhd"
comp -include -dbg "$dsn\src\rt_TB.vhd" 
asim +access +r sr_rt_tb 
wave 
wave -noreg CLK
wave -noreg RST
wave -noreg R_test 
wave -noreg X_test 
wave -noreg OE_test
wave -noreg Y_test
wave -noreg OV_test
# add vars
wave -noreg stim_apply/X_v
wave -noreg stim_apply/R_v
# add transmitter
wave -divider "transmitter"
wave -noreg transmitter_item/IDV
wave -noreg transmitter_item/PDI
wave -noreg transmitter_item/SDO
wave -noreg transmitter_item/ODV
wave -noreg transmitter_item/shift_reg
wave -noreg transmitter_item/counter  
# add receiver
wave -divider "receiver"
wave -noreg receiver_item/IDV
wave -noreg receiver_item/SDI
wave -noreg receiver_item/PDO
wave -noreg receiver_item/RDY
wave -noreg receiver_item/shift_reg
wave -noreg receiver_item/counter
run 3000 ns
