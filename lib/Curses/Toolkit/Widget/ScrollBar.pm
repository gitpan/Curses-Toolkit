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

package Curses::Toolkit::Widget::ScrollBar;
{
  $Curses::Toolkit::Widget::ScrollBar::VERSION = '0.210';
}

use parent qw(Curses::Toolkit::Widget);
use Carp;

our @EXPORT_OK = qw(ScrollBar);
our %EXPORT_TAGS = (all => [qw(ScrollBar)]);

sub ScrollBar { 'Curses::Toolkit::Widget::Scrollbar' }

sub new {
    my $class = shift;
    $class eq __PACKAGE__
        and die
        "This is an abstract class, please see Curses::Toolkit::Widget::VScrollBar and Curses::Toolkit::Widget::HScrollBar";
    my $self  = $class->SUPER::new();
    $self->{fill} = 1;
    $self->{_pressed} = 0;
    $self->{_scrolling} = { enabled => 0 };
    return $self;
}


sub set_visibility_mode {
    my $self = shift;
    my ($visibility_mode) = validate_pos( @_, { regex => qr/^(?:auto|always)$/ } );
    $self->{visibility_mode} = $visibility_mode;
    return $self;
}


sub get_visibility_mode {
    my ($self) = @_;
    return $self->{visibility_mode};
}


sub set_fill {
    my ($self, $fill) = @_;
    $fill <= 1 && $fill > 0
      or croak 'argument to set_fill must be greater than 0 and lower or exqual to 1';
    $self->{fill} = $fill;
    return $self;
}


sub get_fill {
    my ($self) = @_;
    return $self->{fill};
}

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Widget::ScrollBar

=head1 VERSION

version 0.210

=head1 METHODS

=head2 set_visibility_mode

Set the visibility mode of the scrollbar

  input  : one of 'auto', 'always'
  output : the scrollbar object

=head2 get_visibility_mode

Returns the visibility mode of the scrollbar

  input  : none
  output : one of 'auto', 'always'

=head2 set_fill

Set the ratio of the scrollbar that is filled

  input  : ratio number
  output : the scrollbar object

=head2 get_fill

Returns the ratio of te scrollbar that is filled

  input  : none
  output : ratio number

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
