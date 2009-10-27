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

package Curses::Toolkit::Theme::Default;
our $VERSION = '0.093000';


# ABSTRACT: default widget theme

use parent qw(Curses::Toolkit::Theme);

use Params::Validate qw(:all);
use Curses;


# the values of this theme
sub _get_default_properties {
	my ($self, $class_name) = @_;
	my %default = ( 'Curses::Toolkit::Widget::Window' => {
			          title_width => 20,
					  title_bar_position => 'top',
					  title_position => 'left',
					  title_brackets_characters => [ '[ ', ' ]' ],
					  title_left_offset => 1,
					  title_right_offset => 1,
					  title_animation => 1,
					  title_loop_duration => 4,
					  title_loop_pause => 2/3,
					  # inherited from Border
					  border_width => 1,
					},
					'Curses::Toolkit::Widget::Border' => {
					  border_width => 1,
					},
					'Curses::Toolkit::Widget::GenericButton' => {
					  # inherited from Border
					  border_width => 1,
					},
#  					'Curses::Toolkit::Widget::Paned' => {
#  					  gutter_size => 1,
#  					},
# 					'Curses::Toolkit::Widget::Entry' => {
# 					  default_width => 20,
# 					},
				  );
	return $default{$class_name} || {};
}



sub ULCORNER { ACS_ULCORNER; }
sub LLCORNER { ACS_LLCORNER; }
sub URCORNER { ACS_URCORNER; }
sub LRCORNER { ACS_LRCORNER; }
sub HLINE { ACS_HLINE; }
sub VLINE { ACS_VLINE; }

sub STRING_NORMAL  { }
sub STRING_FOCUSED { shift->_attron(A_REVERSE) }
sub STRING_CLICKED { shift->_attron(A_BOLD) }

sub TITLE_NORMAL  { }
sub TITLE_FOCUSED { shift->_attron(A_REVERSE) }
sub TITLE_CLICKED { shift->_attron(A_BOLD) }

sub HLINE_NORMAL   { }
sub HLINE_FOCUSED  { shift->_attron(A_REVERSE) }
sub HLINE_CLICKED  { shift->_attron(A_BOLD) }
				   
sub VLINE_NORMAL   { }
sub VLINE_FOCUSED  { shift->_attron(A_REVERSE) }
sub VLINE_CLICKED  { shift->_attron(A_BOLD) }

sub CORNER_NORMAL  { }
sub CORNER_FOCUSED { shift->_attron(A_REVERSE) }
sub CORNER_CLICKED { shift->_attron(A_BOLD) }

sub RESIZE_NORMAL  { }
sub RESIZE_FOCUSED { shift->_attron(A_REVERSE) }
sub RESIZE_CLICKED { shift->_attron(A_BOLD) }

sub BLANK_NORMAL  { shift->_attrset() }
sub BLANK_FOCUSED { shift->_attrset() }
sub BLANK_CLICKED { shift->_attrset() }

sub draw_hline {
	my ($self, $x1, $y1, $width, $attr) = @_;
	$self->get_widget->is_visible() or return;
	$y1 >= 0 or return;
	my $c = $self->restrict_to_shape(x1 => $x1, y1 => $y1, width => $width, height => 1)
	  or return;
	$self->curses($attr)->hline($c->y1(), $c->x1(), HLINE(), $c->width());
	return $self;
}

sub draw_vline {
	my ($self, $x1, $y1, $height, $attr) = @_;
	$self->get_widget->is_visible() or return;
	$x1 >= 0 or return;
	my $c = $self->restrict_to_shape(x1 => $x1, y1 => $y1, width => 1, height => $height)
	  or return;
	$self->curses($attr)->vline($c->y1(), $c->x1(), VLINE(), $c->height());
	return $self;
}

sub draw_corner_ul {
	my ($self, $x1, $y1, $attr) = @_;
	$self->get_widget->is_visible() or return;
	$self->is_in_shape(x1 => $x1, y1 => $y1, x2 => $x1, y2 => $y1) or return;
 	$self->curses($attr)->addch($y1, $x1, ULCORNER());
	return $self;
}

sub draw_corner_ll {
	my ($self, $x1, $y1, $attr) = @_;
	$self->get_widget->is_visible() or return;
	$self->is_in_shape(x1 => $x1, y1 => $y1, x2 => $x1, y2 => $y1) or return;
 	$self->curses($attr)->addch($y1, $x1, LLCORNER());
	return $self;
}

sub draw_corner_ur {
	my ($self, $x1, $y1, $attr) = @_;
	$self->get_widget->is_visible() or return;
	$self->is_in_shape(x1 => $x1, y1 => $y1, x2 => $x1, y2 => $y1) or return;
 	$self->curses($attr)->addch($y1, $x1, URCORNER());
	return $self;
}

sub draw_corner_lr {
	my ($self, $x1, $y1, $attr) = @_;
	$self->get_widget->is_visible() or return;
	$self->is_in_shape(x1 => $x1, y1 => $y1, x2 => $x1, y2 => $y1) or return;
 	$self->curses($attr)->addch($y1, $x1, LRCORNER());
	return $self;
}

sub draw_string {
	my ($self, $x1, $y1, $text, $attr) = @_;
	$self->get_widget->is_visible() or return;
	my $c = $self->restrict_to_shape(x1 => $x1, y1 => $y1, width => length($text), height => 1) or return;
	$text = substr($text, $c->x1()-$x1, $c->width());
	defined $text && length $text or return;
	$self->curses($attr)->addstr($c->y1(), $c->x1(), $text);
	return $self;
}

sub draw_title {
	my ($self, $x1, $y1, $text, $attr) = @_;
	$self->get_widget->is_visible() or return;
	my $c = $self->restrict_to_shape(x1 => $x1, y1 => $y1, width => length($text), height => 1) or return;
	$text = substr($text, $c->x1()-$x1, $c->width());
	defined $text && length $text or return;
	$self->curses($attr)->addstr($c->y1(), $c->x1(), $text);
	return $self;
}

sub draw_resize {
	my ($self, $x1, $y1, $attr) = @_;
	$self->get_widget->is_visible or return;
	$self->is_in_shape(x1 => $x1, y1 => $y1, x2 => $x1, y2 => $y1) or return;
	$self->curses($attr)->addch($y1, $x1, ACS_CKBOARD);
	return $self;
}

sub draw_blank {
	my $self = shift;
	$self->get_widget->is_visible or return;
	my ($c) = validate_pos( @_, { isa => 'Curses::Toolkit::Object::Coordinates' } );
	$c = $self->restrict_to_shape($c)
	  or return;
	my $l = $c->x2() - $c->x1();
	$l > 0 or return $self;
	my $str = ' ' x $l;
	foreach my $y ($c->y1()..$c->y2()-1) {
		$self->curses->addstr($y, $c->x1(), $str);
	}
	return $self;
}

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Theme::Default - default widget theme

=head1 VERSION

version 0.093000

=head1 DESCRIPTION

This theme is used by default when rendering widgets.

=head1 CONSTRUCTOR

=head2 new

  input : a Curses::Toolkit::Widget
  output : a Curses::Toolkit::Theme::Default



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 