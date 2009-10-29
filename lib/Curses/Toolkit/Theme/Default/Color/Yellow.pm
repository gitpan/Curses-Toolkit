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

package Curses::Toolkit::Theme::Default::Color::Yellow;
our $VERSION = '0.093020';


# ABSTRACT: default widget theme with color

use parent qw(Curses::Toolkit::Theme::Default::Color);

use Params::Validate qw(:all);
use Curses;



sub new {
	my $class = shift;
	has_colors() or
	  die "Cannot create a '" .  __PACKAGE__ . "' object : color is not supported";
	# pair 1 : yellow on blue
	init_pair(1, COLOR_YELLOW, COLOR_BLACK);
	init_pair(2, COLOR_RED, COLOR_BLACK);
	return $class->SUPER::new(@_);
}

sub HLINE_NORMAL   { shift->_attron(COLOR_PAIR(1)) }
sub HLINE_FOCUSED  { shift->_attron(COLOR_PAIR(2) | A_BOLD) }
sub HLINE_CLICKED  { shift->_attron(COLOR_PAIR(1) | A_REVERSE) }
				   
sub VLINE_NORMAL   { shift->_attron(COLOR_PAIR(1)) }
sub VLINE_FOCUSED  { shift->_attron(COLOR_PAIR(2) | A_BOLD) }
sub VLINE_CLICKED  { shift->_attron(COLOR_PAIR(1) | A_REVERSE) }

sub CORNER_NORMAL  { shift->_attron(COLOR_PAIR(1)) }
sub CORNER_FOCUSED { shift->_attron(COLOR_PAIR(2) | A_BOLD) }
sub CORNER_CLICKED { shift->_attron(COLOR_PAIR(1) | A_REVERSE) }

# STRING as parent

sub TITLE_NORMAL  { shift->_attron(COLOR_PAIR(1)) }
sub TITLE_FOCUSED { shift->_attron(COLOR_PAIR(2) | A_BOLD) }
sub TITLE_CLICKED { shift->_attron(COLOR_PAIR(1) | A_REVERSE) }

sub RESIZE_NORMAL  { shift->_attron(COLOR_PAIR(1)) }
sub RESIZE_FOCUSED { shift->_attron(COLOR_PAIR(2) | A_BOLD) }
sub RESIZE_CLICKED { shift->_attron(COLOR_PAIR(1) | A_REVERSE) }


1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Theme::Default::Color::Yellow - default widget theme with color

=head1 VERSION

version 0.093020

=head1 DESCRIPTION

This theme is used by default when rendering widgets, if color is available.

=head1 CONSTRUCTOR

=head2 new

  input : a Curses::Toolkit::Widget
  output : a Curses::Toolkit::Theme::Default::Color object



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 