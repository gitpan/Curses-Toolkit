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

package Curses::Toolkit::Widget::Button;
our $VERSION = '0.093060';


# ABSTRACT: a simple text button widget

use parent qw(Curses::Toolkit::Widget Curses::Toolkit::Role::Focusable);

use Params::Validate qw(:all);
use Curses::Toolkit::Object::Coordinates;



sub new {
	my $class = shift;

	my $self = $class->SUPER::new();
	$self->{text} = '';
	return $self;
}


sub new_with_label {
	my $class = shift;
	my ($text) = validate_pos( @_, { type => SCALAR } );

	my $self = $class->new();
	$self->set_text($text);
	return $self;
}


sub set_text {
	my $self = shift;
	
	my ($text) = validate_pos( @_, { type => SCALAR } );
	$self->{text} = $text;
	return $self;

}


sub get_text {
	my ($self) = @_;
	return $self->{text};
}

# <----- w1 ---->
#   <-- w2 --->
# < button text >
# --^  o1 
# ------- o2 --^ 



sub draw {
	my ($self) = @_;
	my $theme = $self->get_theme();
	my $c = $self->get_coordinates();
	my $text = $self->get_text();

# TODO : theme this !
	my $w1 = $c->width();
	my $w2 = $w1 - 4;
	my $o1 = 2;
	my $o2 = $w1 - 2;
	my $t = ' ' x (($w2 - length $text) / 2);

	$theme->draw_string($c->x1(), $c->y1(), '< ');
	$theme->draw_string($c->x1() + $o2, $c->y1(), ' >');
	$theme->draw_string($c->x1() + $o1, $c->y1(), $t . $text . $t);

	return;
}


sub get_desired_space {	shift->get_minimum_space(@_) }


sub get_minimum_space {
	my ($self, $available_space) = @_;
	my $text = $self->get_text();

	my $desired_space = $available_space->clone();
# TODO : theme this !
	$desired_space->set( x2 => $available_space->x1() + length($text) + 4,
						 y2 => $available_space->y1() + 1,
					   );
	return $desired_space;
}


sub possible_signals {
	my ($self) = @_;
	return ( $self->SUPER::possible_signals(),
			 clicked => 'Curses::Toolkit::Signal::Clicked',
		   );
}

sub _bind_signal {
	my $self = shift;
	my ($signal_name, $code_ref) = validate_pos( @_, { type => SCALAR },
												     { type => CODEREF },
											   );
	my %signals = $self->possible_signals();
	my $signal_class = $signals{$signal_name};
	defined $signal_class
	  or die "signal '$signal_name' doesn't exists for widget of type " . ref($self) . ". Possible signals are : " . join(', ', keys %signals);

	require UNIVERSAL::require;
	$signal_class->require
	  or die $@;
	$self->add_event_listener($signal_class->generate_listener( widget => $self,
																code_ref => $code_ref,
															  )
							 );
	return $self;
}

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Widget::Button - a simple text button widget

=head1 VERSION

version 0.093060

=head1 DESCRIPTION

The Curses::Toolkit::Widget::Button widget is a classical button widget, used
to attach a function that is called when the button is pressed.

This widget cannot hold any widget. If you want a button with a specific
widget, please use L<Curses::Toolkit::Widget::GenericButton>, however it will
use more space in your inerface

=head1 CONSTRUCTOR

=head2 new

  input : none
  output : a Curses::Toolkit::Widget::Button



=head2 new_with_label

  input : the text of the button
  output : a Curses::Toolkit::Widget::Button



=head1 METHODS

=head2 set_text

Set the text of the entry

  input  : STRING, the text
  output : the button object



=head2 get_text

Get the text of the Button

  input  : none
  output : STRING, the Button text



=head2 draw



=head2 get_desired_space

Given a coordinate representing the available space, returns the space desired
The Button desires the minimum size : text length plus the button brackets

  input : a Curses::Toolkit::Object::Coordinates object
  output : a Curses::Toolkit::Object::Coordinates object



=head2 get_minimum_space

Given a coordinate representing the available space, returns the minimum space required
The Button requires the text length plus the button brackets

  input : a Curses::Toolkit::Object::Coordinates object
  output : a Curses::Toolkit::Object::Coordinates object



=head2 possible_signals

my @signals = keys $button->possible_signals();

returns the possible signals that can be used

  input  : none
  output : HASH, keys are siagnal names, values are signal classes



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 