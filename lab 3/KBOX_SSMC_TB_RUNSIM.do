SetActiveLib -work

# compile KBOX files
comp -include "$dsn\src\bf4_conc_CA.vhd"

# compile module with ALU behavioral
comp -include "$dsn\src\ALU_BEHAV.vhd"

# compile module with ALU structural and components
comp -include "$dsn\src\SUM_N.vhd"
comp -include "$dsn\src\SUB_N.vhd"
comp -include "$dsn\src\MUL_N.vhd"
comp -include "$dsn\src\XOR_N.vhd"
comp -include "$dsn\src\CMP_N.vhd"
comp -include "$dsn\src\MUX_N.vhd"
comp -include "$dsn\src\ALU_STRUCT.vhd"

# compile top-level modules
comp -include "$dsn\src\DPU_BEHAV.vhd"
comp -include "$dsn\src\DPU_STRUCT.vhd"

# compile testbench
comp -include "$dsn\src\DPU_TB.vhd"

# begin simulation
asim +access +r dpu_tb
wave

# testbench input signals
wave -noreg -decimal -notation 2compl TEST_A
wave -noreg -decimal -notation 2compl TEST_B
wave -noreg -binary  -color 128,0,0   TEST_CMD

# --------------------------------------------------
wave -divider "DPU_BEHAV:"
# --------------------------------------------------
wave -noreg -decimal -notation 2compl -color purple UUT1/OP1_s
wave -noreg -decimal -notation 2compl -color green  UUT1/OP2_s
#wave -noreg -decimal RES_bh
wave -noreg -decimal -notation 2compl RES_bh
wave -noreg -decimal -notation 2compl -vbus "RES_behav_HIGH" RES_bh(7) RES_bh(6) RES_bh(5) RES_bh(4)
wave -noreg -decimal -notation 2compl -vbus "RES_behav_LOW"  RES_bh(3) RES_bh(2) RES_bh(1) RES_bh(0)
wave -noreg FLC_bh
wave -noreg AGB_bh
wave -noreg AEB_bh
wave -noreg ALB_bh

# --------------------------------------------------
wave -divider "DPU_STRUCT:"
# --------------------------------------------------
wave -noreg -decimal -notation 2compl -color 128,0,128 UUT2/OP1_s
wave -noreg -decimal -notation 2compl -color 0,128,0   UUT2/OP2_s
#wave -noreg -decimal RES_st
wave -noreg -decimal -notation 2compl RES_st
wave -noreg -decimal -notation 2compl -vbus "RES_struct_HIGH" RES_st(7) RES_st(6) RES_st(5) RES_st(4)
wave -noreg -decimal -notation 2compl -vbus "RES_struct_LOW"  RES_st(3) RES_st(2) RES_st(1) RES_st(0)
wave -noreg FLC_st
wave -noreg AGB_st
wave -noreg AEB_st
wave -noreg ALB_st

# run full simulation process
run 960 ns