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

package Curses::Toolkit::Widget::VScrollBar;
our $VERSION = '0.100630';



# ABSTRACT: a vertical scrollbar widget

use parent qw(Curses::Toolkit::Widget);

use Params::Validate qw(:all);


sub new {
    my $class = shift;
    my $self  = $class->SUPER::new();
    $self->{visibility_mode} = 'auto';
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

sub draw {
    my ($self) = @_;
    my $theme => $self->get_theme();
    my $c = get_coordinates();
}


1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Widget::VScrollBar - a vertical scrollbar widget

=head1 VERSION

version 0.100630

=head1 DESCRIPTION

This widget is just the vertical scrollbar. Usually you will want to use 
Curses::Toolkit::Widget::ScrollArea

=head1 CONSTRUCTOR

=head2 new

  input : none
  output : a Curses::Toolkit::Widget::VScrollBar object



=head1 METHODS

=head2 set_visibility_mode

Set the visibility mode of the scrollbar

  input  : one of 'auto', 'always'
  output : the scrollbar object



=head2 get_visibility_mode

Returns the visibility mode of the scrollbar

  input  : none
  output : one of 'auto', 'always'



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 