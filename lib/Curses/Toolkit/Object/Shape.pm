#
# This file is part of Curses-Toolkit
#
# This software is copyright (c) 2011 by Damien "dams" Krotkine.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use warnings;
use strict;

package Curses::Toolkit::Object::Shape;
{
  $Curses::Toolkit::Object::Shape::VERSION = '0.211';
}

# ABSTRACT: simple shape class

use parent qw(Curses::Toolkit::Object::Coordinates);

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);


# Making it readonly

sub set         { _die() }
sub add         { _die() }
sub subtract   { _die() }
sub restrict_to { _die() }

sub _die {
    die " You should not be calling '" . ( caller(1) )[3] . "' on a '" . __PACKAGE__ . "' object, as it's read only.";
}

# private methods

sub _set {
    my $self = shift;
    $self->SUPER::set(@_);
}


1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Object::Shape - simple shape class

=head1 VERSION

version 0.211

=head1 DESCRIPTION

The Shape is the root window area. 
This module is the class implementing the Shape.

Technically, a Shape is a ReadOnly Coordinate, plus some members, states, flags, and methods.

You can have a look at L<Curses::Toolkit::Object::Coordinates>.

=head1 CLASS METHODS

Nothing more than L<Curses::Toolkit::Object::Coordinates> for now

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
