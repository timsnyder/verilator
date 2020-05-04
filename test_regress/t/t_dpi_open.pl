#!/usr/bin/env perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

scenarios(simulator => 1);

compile(
    v_flags2 => ["t/t_dpi_open_c.cpp"],
    verilator_flags2 => ["-Wall -Wno-DECLFILENAME -unroll-count 1"],
    );

execute(
    check_finished => 1,
    );

ok(1);
1;
