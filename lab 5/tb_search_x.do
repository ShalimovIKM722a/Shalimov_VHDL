# script to launch testbench for Lab Work #5 - simple search
SetActiveLib -work
comp -include "$dsn\src\k16_rom.vhd" 
comp -include "$dsn\src\fsm_search_x.vhd" 
comp -include "$dsn\src\search_x.vhd" 
comp -include "$dsn\src\tb_search_x.vhd" 
asim +access +r search_x_tb 
wave 
wave -noreg CLK
wave -noreg RST
wave -noreg R
wave -noreg Y_FIND
wave -noreg START
wave -noreg X_FOUND
wave -noreg FINISH
wave -noreg ERROR 
wave -divider "FSM signals"
wave -noreg UUT/FSM_unit/state
wave -noreg UUT/FSM_unit/X_S
wave -noreg UUT/FSM_unit/Y_S  
run 3.5 us