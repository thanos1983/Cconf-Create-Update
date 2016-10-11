#!/usr/bin/perl
use strict;
use warnings;
use Net::SSH2;
use Data::Dumper;

my $dir = '/home/tinyos/Downloads/Inteliquent/Cconf-Create-Update';

opendir my $dh, $dir
    or die "Could not open '$dir' for reading: $!\n";

my @files = grep {$_ ne '.' and $_ ne '..'} readdir $dh;

# my @files = readdir $dh;

closedir $dh;

print Dumper \@files;

my @output = `ssh -p 19013 tinyos "ls"`;
chomp @output;

print Dumper \@output;

=test
my $ssh2 = Net::SSH2->new();

$ssh2->connect('tinyos', 19013)
    or $ssh2->die_with_error;

my $chan = $ssh2->channel()
    or $ssh2->die_with_error;

$chan->blocking(0);

$chan->exec("ls ./")
    or $ssh2->die_with_error;

while (<$chan>){ print }

print "exit status: " . $chan->exit_status . "\n";

$ssh2->disconnect();
=cut
