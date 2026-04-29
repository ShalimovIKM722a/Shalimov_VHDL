# script to launch testbench for Lab Work #5 - advanced search
SetActiveLib -work
comp -include "$dsn\src\k16_rom.vhd" 
comp -include "$dsn\src\fsm_adv_search_x.vhd" 
comp -include "$dsn\src\adv_search_x.vhd" 
comp -include "$dsn\src\tb_adv_search_x.vhd" 
asim +access +r adv_search_x_tb 
wave 
wave -noreg CLK
wave -noreg RST
wave -noreg Y_TO_FIND
wave -noreg START
wave -noreg X_R0_FOUND
wave -noreg X_R1_FOUND
wave -noreg FINISH
wave -noreg ERROR 
wave -divider "FSM signals"
wave -noreg UUT/FSM_unit/state
wave -noreg UUT/FSM_unit/X_reg
wave -noreg UUT/FSM_unit/Y_S  
run 3.1 us