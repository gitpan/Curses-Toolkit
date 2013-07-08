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
{
  $Curses::Toolkit::Types::VERSION = '0.208';
}

# ABSTRACT: various types used within the dist

sub PROGRESS_BAR_LABEL {
    return({ map { $_ => 1 } (qw(none value percent)) });
}

1;


=pod

=head1 NAME

Curses::Toolkit::Types - various types used within the dist

=head1 VERSION

version 0.208

=head1 DESCRIPTION

This module implements the specific types used by the distribution

Current types defined:

=over

=item * PROGRESS_BAR_LABEL - C<none>, C<value> or C<percent>.

=back

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


