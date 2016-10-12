#!/usr/bin/perl

use strict;
use warnings;
use Net::SSH2;
use Pod::Usage;
use Data::Dumper qw(Dumper);
use Getopt::Long qw(GetOptions);

=important!
To install Net::SSH2 Perl module

debian and ubuntu
apt-get install -y libssl-dev

Centos o fedora
yum install -y openssl-devel
=cut

my $options = {
    'man'       => 0,
    'help'      => 0,
    'dir'       => undef,
    'host'      => undef,
};

GetOptions(
    'man|m'         => \$$options{'man'},
    'help|h'        => \$$options{'help'},
    'dir|d:s'       => \$$options{'dir'},
    'host|h:s'      => \$$options{'host'},
    'port|p:s'      => \$$options{'port'},
    ) or pod2usage(2);

pod2usage(1) if $$options{'help'};
pod2usage(-exitval => 0, -verbose => 2) if $$options{'man'};

die "\nOption --dir or -d not specified.\n\n"
    if (!defined $$options{'dir'} || $$options{'dir'} eq '');

die "\nOption --host or -h not specified.\n\n"
    if (!defined $$options{'host'} || $$options{'host'} eq '');

if (!defined $$options{'port'} || $$options{'port'} eq '')
    { $$options{'port'} = 22; }

opendir(my $dir, $$options{'dir'})
    or die "\ncouldn't open '".$$options{'dir'}."': $!\n\n";

my @files = grep {$_ ne '.' and $_ ne '..'} readdir $dir;

closedir $dir;

print Dumper \@files;

my @output = `ssh -p 19013 tinyos "ls"`;
chomp @output;

print Dumper \@output;

my $ssh2 = Net::SSH2->new();

$ssh2->connect($$options{'host'}, $$options{'port'})
    or $ssh2->die_with_error;

$ssh2->disconnect($$options{'host'})
    or $ssh2->die_with_error;

__END__

=head1 NAME

cconf_replication - process files in specified dir and create them on destination ssh box.

=head1 SYNOPSIS

cconf_replication [OPTIONS]...

Options:
    --dir or -d,
    --help or -h,
    --man or -m

=head1 DESCRIPTION

Process customer care log CDR(s) file to standard output.

=over 8

=item B<-d, --dir>
log file to be processed

=item B<-h, --help>
print a brief help message and exits.

=item B<-m, --man>
prints the manual page full documentation.

=back

=head1 DESCRIPTION

B<This program> will read the given input dir and apply the cconf replication.

=head1 AUTHOR

Written by Athanasios Garyfalos.

=head1 REPORTING BUGS

Please report any bugs or feature requests to GARYFALOS at cpan.org. I will be notified, and I will try to make changes as soon as possible. I will update you with a reply as soon as the modifications will be applied.

=head1 COPYRIGHT

This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.

=cut