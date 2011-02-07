#
# This file is part of Curses-Toolkit
#
# This software is copyright (c) 2011 by Damien "dams" Krotkine.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use strict;
use warnings;

package Curses::Toolkit::Types;
BEGIN {
  $Curses::Toolkit::Types::VERSION = '0.203';
}

# ABSTRACT: various types used within the dist

use Moose::Util::TypeConstraints;

enum PROGRESS_BAR_LABEL => qw( none value percent );

1;


=pod

=head1 NAME

Curses::Toolkit::Types - various types used within the dist

=head1 VERSION

version 0.203

=head1 DESCRIPTION

This module implements the specific types used by the distribution, and
exports them (exporting is done directly by
L<Moose::Util::TypeConstraints>.

Current types defined:

=over 4

=item * PROGRESS_BAR_LABEL - a simple enumeration, allowing only
C<none>, C<value> or C<percent>.

=back

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


