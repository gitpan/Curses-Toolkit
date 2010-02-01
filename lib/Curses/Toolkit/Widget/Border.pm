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

package Curses::Toolkit::Widget::Border;
our $VERSION = '0.100320';


# ABSTRACT: a border widget

use parent qw(Curses::Toolkit::Widget::Bin);

use Params::Validate qw(:all);

use Curses::Toolkit::Object::Coordinates;


sub draw {
	my ($self) = @_;
	my $theme = $self->get_theme();
	my $c = $self->get_coordinates();
	my $border_width = $self->get_theme_property('border_width');

	$border_width > 0 or return;

	for my $i (0..$border_width-1) {
		$theme->draw_hline($c->x1() + $i,     $c->y1() + $i,      $c->width() - 2 * $i);
		$theme->draw_hline($c->x1() + $i,     $c->y2() - $i - 1 , $c->width() - 2 * $i);
		$theme->draw_vline($c->x1() + $i,     $c->y1() + $i,      $c->height() - 2 * $i);
		$theme->draw_vline($c->x2() - $i - 1, $c->y1() + $i,      $c->height() - 2 * $i);

		$theme->draw_corner_ul($c->x1() + $i,     $c->y1() + $i);
		$theme->draw_corner_ll($c->x1() + $i,     $c->y2() - $i - 1);
		$theme->draw_corner_ur($c->x2() - $i - 1, $c->y1() + $i);
		$theme->draw_corner_lr($c->x2() - $i - 1, $c->y2() - $i - 1);
	}
	return;
}

# Returns the relative rectangle that a child widget can occupy.
# This returns the current widget space, shrinked by the border size
#
# input : none
# output : a Curses::Toolkit::Object::Coordinates object

sub _get_available_space {
	my ($self) = @_;
	my $rc = $self->get_relatives_coordinates();
	my $bw = $self->get_theme_property('border_width');
	return Curses::Toolkit::Object::Coordinates->new(
		x1 => $bw, y1 => $bw,
        x2 => $rc->width() - $bw, y2 => $rc->height() - $bw,
	);
}


sub get_desired_space {
	my ($self, $available_space) = @_;
	my $desired_space = $available_space->clone();
	return $desired_space;
}


sub get_minimum_space {
	my ($self, $available_space) = @_;
	my ($child) = $self->get_children();
	my $child_space = Curses::Toolkit::Object::Coordinates->new_zero();
	my $bw = $self->get_theme_property('border_width');
	if (defined $child) {
		my $child_available_space = $available_space->clone();
		$child_available_space->set( x1 => $available_space->x1() + $bw, y1 => $available_space->y1() + $bw,
									 x2 => $available_space->x2() - $bw, y2 => $available_space->y2() - $bw,
								   );
		$child_space = $child->get_minimum_space($child_available_space);
	}
	my $minimum_space = $available_space->clone();
	$minimum_space->set( x2 => $available_space->x1() + $child_space->width() + 2 * $bw,
						 y2 => $available_space->y1() + $child_space->height() + 2 * $bw,
					   );
	return $minimum_space;
}


sub _get_theme_properties_definition {
	my ($self) = @_;
	return { %{$self->SUPER::_get_theme_properties_definition() },
			 border_width => {
			   optional => 1,
			   type => SCALAR,
			   callbacks => { "positive integer" => sub { $_[0] >= 0 } }
			 },
		   }
}

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Widget::Border - a border widget

=head1 VERSION

version 0.100320

=head1 Appearence

  +----------+
  |          |
  +----------+

=head1 DESCRIPTION

This widget consists of a border, and a child widget in that border

This widget can contain 0 or 1 other widget.

=head1 CONSTRUCTOR

=head2 new

  input : none
  output : a Curses::Toolkit::Widget::Border



=head2 get_desired_space

Given a coordinate representing the available space, returns the space desired
The Border desires all the space available, so it returns the available space

  input : a Curses::Toolkit::Object::Coordinates object
  output : a Curses::Toolkit::Object::Coordinates object



=head2 get_minimum_space

Given a coordinate representing the available space, returns the minimum space
needed to properly display itself

  input : a Curses::Toolkit::Object::Coordinates object
  output : a Curses::Toolkit::Object::Coordinates object



=head1 Theme related properties

To set/get a theme properties, you should do :

  $border->set_theme_property(property_name => $property_value);
  $value = $border->get_theme_property('property_name');

Here is the list of properties related to the border, that can be changed in
the associated theme. See the Curses::Toolkit::Theme class used for the default
(default class to look at is Curses::Toolkit::Theme::Default)

Don't forget to look at properties from the parent class, as these are also
inherited from !

=head2 border_width

Sets the width of the border. If not set, the border will be invisible



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 