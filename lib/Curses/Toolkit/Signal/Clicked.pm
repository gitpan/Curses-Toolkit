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

package Curses::Toolkit::Signal::Clicked;
our $VERSION = '0.093060';



use parent qw(Curses::Toolkit::Signal);

use Params::Validate qw(:all);


sub generate_listener {
	my $class = shift;
	my %args = validate( @_,
						 { widget => { isa => 'Curses::Toolkit::Widget' },
						   code_ref => { type => CODEREF },
						 },
					   );
	my $widget = $args{widget};
	my $code_ref = $args{code_ref};

	return Curses::Toolkit::EventListener->new(
		accepted_events => {
			'Curses::Toolkit::Event::Key' => sub { 
				my ($event) = @_;
				$event->{type} eq 'stroke' or return 0;
				$event->{params}{key} eq ' ' or return 0;
				return 1;
			},
			'Curses::Toolkit::Event::Mouse::Click' => sub { 
				my ($event) = @_;
				$event->{type} eq 'clicked' or return 0;
				$event->{button} eq 'button1' or return 0;
				return 1;
			},
		},
		code => sub {
			$widget->can('set_focus') and $widget->set_focus(1);
			$widget->can('flash') and $widget->flash();
			$code_ref->();
		},
	);
}

1;

__END__

=pod

=head1 VERSION

version 0.093060

=head1 NAME

Curses::Toolkit::Signal::Clicked

=head1 DESCRIPTION

Signal triggered when a widget is clicked or activated

=head1 SYNOPSIS

  $widget->signal_connect( clicked => sub { do_stuf(...) } );



=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 