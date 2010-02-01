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
our $VERSION = '0.100320';


# ABSTRACT: default widget theme with color

use parent qw(Curses::Toolkit::Theme::Default::Color);

use Params::Validate qw(:all);
use Curses;



sub new {
	my $class = shift;
	has_colors() or
	  die "Cannot create a '" .  __PACKAGE__ . "' object : color is not supported";
	return $class->SUPER::new(@_);
}

sub default_fgcolor { 'yellow' }
sub default_bgcolor { 'black' }

sub HLINE_NORMAL   { shift->_set_colors('yellow',  'black') }
sub HLINE_FOCUSED  { shift->_set_colors('red',  'black')->_attron(A_BOLD) }
sub HLINE_CLICKED  { shift->_set_colors('yellow',  'black')->_attron(A_REVERSE) }
				   
sub VLINE_NORMAL   { shift->_set_colors('yellow',  'black') }
sub VLINE_FOCUSED  { shift->_set_colors('red',  'black')->_attron(A_BOLD) }
sub VLINE_CLICKED  { shift->_set_colors('yellow',  'black')->_attron(A_REVERSE) }

sub CORNER_NORMAL  { shift->_set_colors('yellow',  'black') }
sub CORNER_FOCUSED { shift->_set_colors('red',  'black')->_attron(A_BOLD) }
sub CORNER_CLICKED { shift->_set_colors('yellow',  'black')->_attron(A_REVERSE) }

sub STRING_NORMAL  { shift->_set_colors('white', 'black') }
sub STRING_FOCUSED { shift->_set_colors('white', 'black')->_attron(A_REVERSE) }
sub STRING_CLICKED { shift->_set_colors('white', 'black')->_attron(A_BOLD) }

sub TITLE_NORMAL  { shift->_set_colors('yellow',  'black') }
sub TITLE_FOCUSED { shift->_set_colors('red',  'black')->_attron(A_BOLD) }
sub TITLE_CLICKED { shift->_set_colors('yellow',  'black')->_attron(A_REVERSE) }

sub RESIZE_NORMAL  { shift->_set_colors('yellow',  'black') }
sub RESIZE_FOCUSED { shift->_set_colors('red',  'black')->_attron(A_BOLD) }
sub RESIZE_CLICKED { shift->_set_colors('yellow',  'black')->_attron(A_REVERSE) }


1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Theme::Default::Color::Yellow - default widget theme with color

=head1 VERSION

version 0.100320

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