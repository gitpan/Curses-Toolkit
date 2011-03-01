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

package Curses::Toolkit::Widget::VPaned;
BEGIN {
  $Curses::Toolkit::Widget::VPaned::VERSION = '0.204';
}

# ABSTRACT: a container with two panes arranged horizontally
use parent qw(Curses::Toolkit::Widget::Paned);

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);



sub _p1 {
    my ( $self, $c ) = @_;
    return $c->get_y1();
}

sub _p2 {
    my ( $self, $c ) = @_;
    return $c->get_x2();
}

sub _p3 {
    my ( $self, $c ) = @_;
    return $c->height();
}

sub _p4 {
    my ( $self, $c, $gp ) = @_;
    return ( y2 => $c->get_y1() + $gp );
}

sub _p5 {
    my ( $self, $c, $gp, $gw ) = @_;
    return ( y1 => $c->get_y1() + $gp + $gw );
}

sub _p6 {
    my ( $self, $gp, $gw ) = @_;
    return ( y2 => $gp + $gw, x2 => 1 );
}

sub _p7 {
    my ( $self, $theme, $c, $i, $gp, $attr ) = @_;
    $theme->draw_hline( $c->get_x1(), $c->get_y1() + $gp + $i, $c->width(), $attr );
    return;
}

sub _p8 {
    my ( $self, $c, $gp, $gw ) = @_;
    return ( y2 => $c->get_y1() + $gp + $gw );
}

sub _p9 {
    my ( $self, $c ) = @_;
    return ( x2 => $c->get_x2() );
}

sub _p10 {
    my ( $self, $c ) = @_;
    return ( y1 => $c->get_y1() );
}

sub _p11 {
    my ( $self, $c1, $c2 ) = @_;
    return ( y2 => $c1->get_y1() + $c1->height() + $c2->height() );
}

sub _p12 {
    my ( $self, $c ) = @_;
    return ( x2 => $c->get_x1() + 1 );
}

sub _p13 {
    my ( $self, $c1, $c2 ) = @_;
    use List::Util qw(max);
    return ( x2 => max( $c1->get_x2(), $c2->get_x2() ) );
}


1;

__END__
=pod

=head1 NAME

Curses::Toolkit::Widget::VPaned - a container with two panes arranged horizontally

=head1 VERSION

version 0.204

=head1 DESCRIPTION

This widget contain 2 widgets. The children are packed horizontally.

=head1 Appearence

With a border

  +----------+-----------+
  |          |           |
  | Widget 1 | Widget 2  |
  |          |           |
  |          |           |
  +----------+-----------+

=head1 CONSTRUCTOR

=head2 new

  input : none
  output : a Curses::Toolkit::Widget::VPaned

=head1 METHODS

=head2 add1

Add a widget in the upper box

  input  : the child widget
  output : the current widget (not the child widget)

=head2 add2

Add a widget in the lower box

  input  : the child widget
  output : the current widget (not the child widget)

=head2 set_gutter_position

Set the position of the gutter from the top

  input  : the position (an integer)
  output : the current widget (not the child widget)

=head2 get_gutter_position

Return the position of the gutter from the top

  input  : none
  output : the current gutter position

=head2 get_desired_space

Given a coordinate representing the available space, returns the space desired

  input : a Curses::Toolkit::Object::Coordinates object
  output : a Curses::Toolkit::Object::Coordinates object

=head2 get_minimum_space

Given a coordinate representing the available space, returns the minimum space
needed to properly display itself

  input : a Curses::Toolkit::Object::Coordinates object
  output : a Curses::Toolkit::Object::Coordinates object

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

