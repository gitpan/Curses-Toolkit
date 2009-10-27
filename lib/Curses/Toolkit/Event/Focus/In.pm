# 
# This file is part of Curses-Toolkit
# 
# This software is copyright (c) 2008 by Damien "dams" Krotkine.
# 
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
# 
use warnings;
use strict;

package Curses::Toolkit::Event::Focus::In;
our $VERSION = '0.093000';


# ABSTRACT: event that is related to in-focus

use parent qw(Curses::Toolkit::Event::Focus);

use Params::Validate qw(:all);


sub new {
	my $class = shift;
	my $self = $class->SUPER::new();
	my %args = validate( @_,
						 { 
						   root_window => { isa => 'Curses::Toolkit' },
						 }
					   );
	$self = bless(\%args, $class);
	return $self;
}

# this event has to be dispatched on a specific widget, so get_matching_widget
# returns void
sub get_matching_widget { return }

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Event::Focus::In - event that is related to in-focus

=head1 VERSION

version 0.093000

=head1 DESCRIPTION

Event that is related to in-focus

=head1 CONSTRUCTOR

=head2 new

  input : root_window : Curses::Toolkit : the root window object



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 