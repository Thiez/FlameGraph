#!/usr/bin/perl -w
#
# msbuild.pl	Convert msbuild logs to the flamegraph input format
##
# Copyright (c) 2018 Matthijs Hofstra.
# All rights reserved.
#
# 02-Jan-2018   Matthijs Hofstra   Created this.

use strict;

my $target;
my $project;

while (<>) {
	chomp;
	my $line = $_;
	if ($line =~ /^.*Done building target "(?<target>[^"]+)" in project "(?<project>[^"]+)"\.:.*$/) {
		$target = "$+{target}";
		$project = "$+{project}";
	}
	elsif ($line =~ /^[^ ]*(?<ws> +)(?<ms>[\d])+ ms +(?<operation>[^ ]+).*$/ && length "$+{ws}" <= 8) {
		print "$project;$target;$+{operation} $+{ms}\n";
	} else {
		#print "$line\n";
	}
}
