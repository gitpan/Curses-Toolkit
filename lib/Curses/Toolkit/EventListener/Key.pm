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

package Curses::Toolkit::EventListener::Key;
BEGIN {
  $Curses::Toolkit::EventListener::Key::VERSION = '0.201';
}

# ABSTRACT: event listener listening for a keyboard action

# XXX : THIS STUFF IS NEVER USED

use parent qw(Curses::Toolkit::EventListener);

use Params::Validate qw(:all);



1;

__END__
=pod

=head1 NAME

Curses::Toolkit::EventListener::Key - event listener listening for a keyboard action

=head1 VERSION

version 0.201

=head1 DESCRIPTION

Key related event listener.

=head1 CONSTRUCTOR

=head2 new

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

