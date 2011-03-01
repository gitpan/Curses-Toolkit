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

package Curses::Toolkit::Role;
BEGIN {
  $Curses::Toolkit::Role::VERSION = '0.205';
}

# ABSTRACT: base class for roles, before migrating to Moose


sub new {
    my ($class) = shift;

    # TODO : use Exception;
    $class eq __PACKAGE__ and die "abstract class";
}

1;

__END__
=pod

=head1 NAME

Curses::Toolkit::Role - base class for roles, before migrating to Moose

=head1 VERSION

version 0.205

=head1 DESCRIPTION

Base class for Roles. Thiw will disappear once I use Moose and don't need
multiple inheriatance anmore.

=head1 CONSTRUCTOR

None, this is an abstract class

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

