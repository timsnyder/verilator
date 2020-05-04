#!/usr/bin/env perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003-2009 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

scenarios(simulator => 1);

top_filename("t/t_assert_basic.v");

compile(
    v_flags2 => ['+define+FAILING_ASSERTIONS',
                 ($Self->{vlt_all} ? '--assert'
                  : ($Self->{nc} ? '+assert' : ''))],
    fails => $Self->{nc},
    );

execute(
    fails => $Self->{vlt_all},
    );

ok(1);
1;
