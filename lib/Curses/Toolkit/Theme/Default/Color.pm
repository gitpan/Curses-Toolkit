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

package Curses::Toolkit::Theme::Default::Color;
our $VERSION = '0.100630';



# ABSTRACT: base class for default coloured widgets themes

use parent qw(Curses::Toolkit::Theme::Default);

use Params::Validate qw(:all);
use Curses;


1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Theme::Default::Color - base class for default coloured widgets themes

=head1 VERSION

version 0.100630

=head1 DESCRIPTION

Base class for default coloured widgets themes

=head1 CONSTRUCTOR

None, this is an abstract class



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 