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

package Curses::Toolkit::Object::Flags;
BEGIN {
  $Curses::Toolkit::Object::Flags::VERSION = '0.202';
}

# ABSTRACT: simple collection of flags

use parent qw(Curses::Toolkit::Object);


sub new {
    my $class = shift;
    my $self  = bless {
        focused  => 0,
        selected => 0,
        clicked  => 0,
    }, $class;
    return $self;
}

1;

__END__
=pod

=head1 NAME

Curses::Toolkit::Object::Flags - simple collection of flags

=head1 VERSION

version 0.202

=head1 DESCRIPTION

Trivial class to hold widgets flags.
The list of flags is :

  focused  : BOOLEAN
  selected : BOOLEAN
  clicked  : BOOLEAN

=head1 CONSTRUCTOR

=head2 new

  input  : none
  output : a Curses::Toolkit::Object::Flags object

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

