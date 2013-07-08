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

package Curses::Toolkit::Event::Content::Changed;
{
  $Curses::Toolkit::Event::Content::Changed::VERSION = '0.208';
}

# ABSTRACT: event that is related to content change

use parent qw(Curses::Toolkit::Event::Content);

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);


# this event has to be dispatched on a specific widget, so get_matching_widget
# returns void
sub get_matching_widget { return }

1;

__END__
=pod

=head1 NAME

Curses::Toolkit::Event::Content::Changed - event that is related to content change

=head1 VERSION

version 0.208

=head1 DESCRIPTION

Event that is related to content change

=head1 CONSTRUCTOR

=head2 new

  input  : none
  output : a Curses::Toolkit::Event::Content::Changed

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

