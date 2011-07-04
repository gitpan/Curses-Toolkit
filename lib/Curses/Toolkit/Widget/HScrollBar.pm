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

package Curses::Toolkit::Widget::HScrollBar;
BEGIN {
  $Curses::Toolkit::Widget::HScrollBar::VERSION = '0.207';
}

# ABSTRACT: an horizontal scrollbar widget

use parent qw(Curses::Toolkit::Widget::ScrollBar);

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);


sub new {
    my $class = shift;
    my $self  = $class->SUPER::new();
    $self->{visibility_mode} = 'auto';
    return $self;
}

sub draw {
    my ($self) = @_;
    my $theme = $self->get_theme();
    my $c = $self->get_coordinates();

    $theme->draw_string( $c->get_x1(), $c->get_y1(), '&lt;');
    $theme->draw_hline( $c->get_x1()+1, $c->get_y1(), $c->width()-2);
    $theme->draw_string( $c->get_x2()-1, $c->get_y1(), '>');
    return;
}

sub possible_signals {
    my ($self) = @_;
    return (
        $self->SUPER::possible_signals(),
        scrolled_up => 'Curses::Toolkit::Signal::Scrolled::Up',
        scrolled_down => 'Curses::Toolkit::Signal::Scrolled::Down',
    );
}

1;

__END__
=pod

=head1 NAME

Curses::Toolkit::Widget::HScrollBar - an horizontal scrollbar widget

=head1 VERSION

version 0.207

=head1 DESCRIPTION

This widget is just the horizontal scrollbar. Usually you will want to use 
Curses::Toolkit::Widget::ScrollArea. It inherits from Curses::Toolkit::Widget::ScrollBar.

=head1 CONSTRUCTOR

=head2 new

  input : none
  output : a Curses::Toolkit::Widget::HScrollBar object

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

