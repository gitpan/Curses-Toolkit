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

package Curses::Toolkit::Signal::Content;
{
  $Curses::Toolkit::Signal::Content::VERSION = '0.209';
}

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);


1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Signal::Content

=head1 VERSION

version 0.209

=head1 DESCRIPTION

Base class for signals that are related to content

=head1 NAME

Curses::Toolkit::Signal::Content - base class for signals that are related to content

=head1 CONSTRUCTOR

None, this is an abstract class

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
