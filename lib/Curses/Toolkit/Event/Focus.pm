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

package Curses::Toolkit::Event::Focus;
{
  $Curses::Toolkit::Event::Focus::VERSION = '0.210';
}

# ABSTRACT: base class for focus events

use parent qw(Curses::Toolkit::Event);



1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Event::Focus - base class for focus events

=head1 VERSION

version 0.210

=head1 DESCRIPTION

Base class for focus events

=head1 CONSTRUCTOR

None, this is an abstract class

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
