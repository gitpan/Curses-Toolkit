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

package Curses::Toolkit::Event::Mouse;
{
  $Curses::Toolkit::Event::Mouse::VERSION = '0.208';
}

# ABSTRACT: base class for mouse events

use parent qw(Curses::Toolkit::Event);

1;


=pod

=head1 NAME

Curses::Toolkit::Event::Mouse - base class for mouse events

=head1 VERSION

version 0.208

=head1 DESCRIPTION

Base class for mouse events.

=head1 CONSTRUCTOR

None, this is an abstract class.

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

