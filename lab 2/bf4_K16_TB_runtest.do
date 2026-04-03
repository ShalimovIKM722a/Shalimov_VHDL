SetActiveLib -work
comp -include "$dsn\src\bf4_conc_CA.vhd" 
comp -include "$dsn\src\bf4_conc_WS.vhd"
comp -include "$dsn\src\bf4_const.vhd"
comp -include "$dsn\src\bf4_logic.vhd"
comp -include "$dsn\src\bf4_proc_IF.vhd"
comp -include "$dsn\src\bf4_proc_CASE.vhd"
comp -include "$dsn\src\bf4_K16_TB.vhd" 
asim +access +r bf4_test_tb 
wave 
wave -noreg X
wave -noreg Y_conc_CA
wave -noreg Y_conc_WS
wave -noreg Y_const  
wave -noreg Y_logic
wave -noreg Y_proc_IF
wave -noreg Y_proc_CASE
wave -noreg TEST_PHASE
wave -noreg VERIF_STATE
run 350 ns