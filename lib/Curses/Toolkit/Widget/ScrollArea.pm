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

package Curses::Toolkit::Widget::ScrollArea;
BEGIN {
  $Curses::Toolkit::Widget::ScrollArea::VERSION = '0.204';
}

# ABSTRACT: a vertical scrollable area

use parent qw(Curses::Toolkit::Widget::Bin);

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new();
#    $self->{visibility_mode} = 'auto';
    return $self;
}

# Returns the relative rectangle that a child widget can occupy. Overloads the
# method from Curses::Toolkit::Widget::Container : we return the virtual space
# of the scroll area, instead of the real coordinates.
#
# input  : none
# output : a Curses::Toolkit::Object::Coordinates object

sub _get_available_space {
    my ($self) = @_;
#    my $rc = $self->get_relatives_coordinates();
    use Curses::Toolkit::Object::Coordinates;
    return Curses::Toolkit::Object::Coordinates->new(
        x1 => 0,   y1 => 0,
        x2 => 300, y2 => 300,
    );
}


sub get_desired_space {

    my ( $self, $available_space ) = @_;

    my $desired_space = $available_space->clone();
    return $desired_space;
}

1;

__END__
=pod

=head1 NAME

Curses::Toolkit::Widget::ScrollArea - a vertical scrollable area

=head1 VERSION

version 0.204

=head2 get_desired_space

Given a coordinate representing the available space, returns the space desired
The ScrollArea desires all the space available, so it returns the available space

  input : a Curses::Toolkit::Object::Coordinates object
  output : a Curses::Toolkit::Object::Coordinates object

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

