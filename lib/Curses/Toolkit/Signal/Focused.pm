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

package Curses::Toolkit::Signal::Focused;
BEGIN {
  $Curses::Toolkit::Signal::Focused::VERSION = '0.201';
}

use parent qw(Curses::Toolkit::Signal);

use Params::Validate qw(:all);


sub generate_listener {
    my $class = shift;
    my %args  = validate(
        @_,
        {   widget    => { isa  => 'Curses::Toolkit::Widget' },
            code_ref  => { type => CODEREF },
            arguments => { type => ARRAYREF },
        },
    );
    my $widget    = $args{widget};
    my $code_ref  = $args{code_ref};
    my @arguments = @{ $args{arguments} };

    return Curses::Toolkit::EventListener->new(
        accepted_events => {
            'Curses::Toolkit::Event::Focus' => sub {
                my ($event) = @_;
                return 1;
            },
        },
        code => sub {
            $code_ref->( @_, @arguments );
        },
    );
}

1;

__END__
=pod

=head1 NAME

Curses::Toolkit::Signal::Focused

=head1 VERSION

version 0.201

=head1 DESCRIPTION

Signal triggered when a widget is focused

=head1 NAME

Curses::Toolkit::Signal::Focused

=head1 CONSTRUCTOR

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

