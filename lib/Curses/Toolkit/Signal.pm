# 
# This file is part of Curses-Toolkit
# 
# This software is copyright (c) 2008 by Damien "dams" Krotkine.
# 
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
# 
package Curses::Toolkit::Signal;
our $VERSION = '0.092920';



use warnings;
use strict;

use Params::Validate qw(:all);


sub new {
    my $class = shift;
    $class eq __PACKAGE__ and die "abstract class";
	return bless { }, $class;
}

# returns the type of the signal
sub get_type {
	my ($self) = @_;
	return $self->{type};
}

1;

__END__

=pod

=head1 VERSION

version 0.092920

=head1 NAME

Curses::Toolkit::Signal - base class for signals

=head1 DESCRIPTION

Base class for signals

=head1 CONSTRUCTOR

None, this is an abstract class



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 