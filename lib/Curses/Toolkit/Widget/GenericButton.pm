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

package Curses::Toolkit::Widget::GenericButton;
{
  $Curses::Toolkit::Widget::GenericButton::VERSION = '0.211';
}

# ABSTRACT: a button widget that can hold any other widget

use parent qw(Curses::Toolkit::Widget::Border Curses::Toolkit::Role::Focusable);

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);
use Curses::Toolkit::Object::Coordinates;

our @EXPORT_OK = qw(GenericButton);
our %EXPORT_TAGS = (all => [qw(GenericButton)]);

sub GenericButton { 'Curses::Toolkit::Widget::GenericButton' }


sub new_with_label {
    my $class = shift;
    my ($label_text) = validate_pos( @_, { type => SCALAR } );
    my $self = $class->new();
    $self->add_widget( Curses::Toolkit::Widget::Label->new()->set_text($label_text) );
    return $self;
}

# The difference with Border is that we don't want to expand when not
# necessary. Meaning, when asked for desired_space, we return the minimum space

sub get_desired_space {
    my $self = shift;
    return $self->get_minimum_space(@_);
}

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Widget::GenericButton - a button widget that can hold any other widget

=head1 VERSION

version 0.211

=head1 DESCRIPTION

The Curses::Toolkit::Widget::GenericButton widget is generally used to attach a
function that is called when the button is pressed.

This widget can hold any valid child widget. That is it can hold most any other
standard Widget. The most commonly used child is the
Curses::Toolkit::Widget::Label. This widget consists of a border, and a child
widget in that border.

However, if all you need is a simple text button, I recommend you use
L<Curses::Toolkit::Widget::Button>, it can take less space on the screen ( it
can have no border ), and has more theme properties that suites best text
buttons.

This widget can contain 0 or 1 other widget.

=head1 CONSTRUCTOR

=head2 new

  input : none
  output : a Curses::Toolkit::Widget::GenericButton

=head2 new_with_label

This creates a button with a Curses::Toolkit::Widget::Label for you.

  input : the label of the button
  output : a Curses::Toolkit::Widget::GenericButton

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
