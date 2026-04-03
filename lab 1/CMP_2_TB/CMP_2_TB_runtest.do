SetActiveLib -work
comp -include "$dsn\src\CMP_1.vhd"
comp -include "$dsn\src\CMP_2.vhd"
comp -include "$dsn\src\CMP_2_TB\CMP_2_TB.vhd"
asim +access +r TB_CMP_2_CONF
wave
wave -noreg A
wave -noreg B
wave -noreg EQ_behav
wave -noreg EQ_struct
run 1600 ns