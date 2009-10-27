# 
# This file is part of Curses-Toolkit
# 
# This software is copyright (c) 2008 by Damien "dams" Krotkine.
# 
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
# 
use warnings;
use strict;

package Curses::Toolkit::Event;
our $VERSION = '0.093000';


# ABSTRACT: base class for events

use Params::Validate qw(:all);


sub new {
    my $class = shift;
    $class eq __PACKAGE__ and die "abstract class";
	return bless { }, $class;
}

# returns the type of the event
sub get_type {
	my ($self) = @_;
	return $self->{type};
}

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Event - base class for events

=head1 VERSION

version 0.093000

=head1 DESCRIPTION

Base class for events

=head1 CONSTRUCTOR

None, this is an abstract class



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 