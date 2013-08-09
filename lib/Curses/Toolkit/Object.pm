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

package Curses::Toolkit::Object;
{
  $Curses::Toolkit::Object::VERSION = '0.209';
}
# ABSTRACT: base class for objects

sub new {
    my $class = shift;
    $class eq __PACKAGE__ and die "abstract class";
    return bless { }, $class;
}

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Object - base class for objects

=head1 VERSION

version 0.209

=head1 DESCRIPTION

Base class for objects. This class cannot be instanciated.

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
