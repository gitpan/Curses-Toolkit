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

package Curses::Toolkit::Event::Content;
BEGIN {
  $Curses::Toolkit::Event::Content::VERSION = '0.207';
}

# ABSTRACT: base class for content events

use parent qw(Curses::Toolkit::Event);

1;


=pod

=head1 NAME

Curses::Toolkit::Event::Content - base class for content events

=head1 VERSION

version 0.207

=head1 DESCRIPTION

Base class for content events.

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

