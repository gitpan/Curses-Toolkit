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

package Curses::Toolkit::Role::Focusable;
our $VERSION = '0.092920';


# ABSTRACT: This role implements the fact that a widget can have focus

use parent qw(Curses::Toolkit::Role);

use Params::Validate qw(:all);


sub new {
    my ($class) = shift;
    # TODO : use Exception;
    # $class eq __PACKAGE__ and;
	die "role class, has no constructor";
}


sub is_focusable {
    my ($self) = @_;
	return($self->is_sensitive() ? 1 : 0);
}


sub set_focus {
	my $self = shift;
	my ($focus) = validate_pos( @_, { type => BOOLEAN } );

	$self->is_focusable()
	  or return $self;
	
	if ($self->can('get_window')) {
		my $window = $self->get_window();
		if (defined $window) {
			my $root_window = $window->get_root_window();
			if (defined $root_window) {
				if ($focus) {
					use Curses::Toolkit::Event::Focus::In;
					my $event_focus_in = Curses::Toolkit::Event::Focus::In->new( root_window => $root_window );
					$root_window->dispatch_event($event_focus_in, $self, 1);
					$window->set_focused_widget($self);
				} else {
					use Curses::Toolkit::Event::Focus::Out;
					my $event_focus_out = Curses::Toolkit::Event::Focus::Out->new( root_window => $root_window );
					$root_window->dispatch_event($event_focus_out, $self, 1);
				}
			}
		}
	}
	$self->set_property(basic => 'focused', $focus ? 1 : 0);
	$self->needs_redraw();
	return $self;
}


sub is_focused {
	my ($self) = @_;
	return $self->get_property(basic => 'focused');
}

1;



__END__

=pod

=head1 NAME

Curses::Toolkit::Role::Focusable - This role implements the fact that a widget can have focus

=head1 VERSION

version 0.092920

=head1 DESCRIPTION

If a widget inherits of this role, it can be focused (except if its sensitivity
is set to false). This will disappear once I use Moose and don't need
multiple inheritance anymore.

This role can be merged in anything that is a Curses::Toolkit::Widget

=head1 CONSTRUCTOR

None, this is a role, so it has no constructor



=head2 is_focusable

Returns 1, except if the widget has its sensitivity set to false



=head2 set_focus

  $widget->set_focus(1); # set focus to this widget
  $widget->set_focus(0); # remove focus from this widget

Sets the focus on/off on the widget.

  input : a boolean
  output : the widget



=head2 is_focused

Retrieves the focus setting of the widget.

  input : none
  output : true if the widget is focused, or false if not



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 