#!/usr/bin/env perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0
use IO::File;
#use Data::Dumper;
use strict;
use vars qw($Self);

scenarios(simulator => 1);

sub gen {
    my $filename = shift;

    my $fh = IO::File->new(">$filename");
    $fh->print(chr(0xEF).chr(0xBB).chr(0xBF));  # BOM
    $fh->print("// Bom\n");
    $fh->print("// Generated by t_unicode.pl\n");
    $fh->print("module t;\n");
    $fh->print("   // Chinese "
               .chr(0xe8).chr(0xaf).chr(0x84).chr(0xe8).chr(0xae).chr(0xba)  # Comment
               ."\n");
    $fh->print("   initial begin\n");
    $fh->print("      \$write(\"Hello "
               .chr(0xe4).chr(0xb8).chr(0x96).chr(0xe7).chr(0x95).chr(0x8c)  # World
               ."\\n\");\n");
    $fh->print("      \$write(\"*-* All Finished *-*\\n\");\n");
    $fh->print("      \$finish;\n");
    $fh->print("   end\n");
    $fh->print("endmodule\n");
}

top_filename("$Self->{obj_dir}/t_unicode.v");

gen($Self->{top_filename});

compile(
    );

execute(
    check_finished => 1,
    expect => q{Hello \344\270\226\347\225\214.*},
    );

ok(1);
1;
