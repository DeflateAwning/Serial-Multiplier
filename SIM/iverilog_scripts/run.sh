#!/bin/bash

# halt if any stage's exit code is not 0
set -e

print_bar() {
    echo "======================================================================================"
}

# Print the version of the tools used
iverilog -V 2>/dev/null | head -n 1

print_bar

IVERILOG_ARGS='-g2012 -Wall'
VVP_ARGS=''
VVP_RUN_LOG_FILENAME='/tmp/vvp_run_log.txt'
export IVERILOG_DUMPER=vcd

print_bar

# create empty run log
date --iso-8601=seconds > $VVP_RUN_LOG_FILENAME

print_bar
echo "=== Building tb_multiplier.sv"
iverilog $IVERILOG_ARGS -o ./tb_multiplier.iv_sim.vvp ./multiplier.sv ./tb_multiplier.sv
echo "iverilog exit code: $?"
echo "=== Running tb_multiplier"
vvp $VVP_ARGS ./tb_multiplier.iv_sim.vvp | tee -a $VVP_RUN_LOG_FILENAME
echo "=== Done tb_multiplier"
