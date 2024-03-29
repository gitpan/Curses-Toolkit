#!/usr/bin/env perl
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

use lib qw(../../../lib);
main() unless caller;

sub main {

	use POE::Component::Curses;

	#	use Curses::Toolkit;
	use Curses::Toolkit::Widget::Window;
	use Curses::Toolkit::Widget::Border;
	use Curses::Toolkit::Widget::Label;
	use Curses::Toolkit::Widget::VBox;
	use Curses::Toolkit::Widget::HBox;
	use Curses::Toolkit::Widget::Button;

	my $root = POE::Component::Curses->spawn();

	#	my $root = Curses::Toolkit->init_root_window();

	local $| = 1;
	open STDERR, '/dev/null';

	$root->add_window(
		Curses::Toolkit::Widget::Window->new()->add_widget(
			Curses::Toolkit::Widget::Border->new()->add_widget(
				my $vbox = Curses::Toolkit::Widget::VBox->new()->pack_end(
					my $hbox = Curses::Toolkit::Widget::HBox->new()->pack_end(
						my $button1 = Curses::Toolkit::Widget::Button->new_with_label('Click me (please) !'),
						{ expand => 0 }
					),
					{ expand => 0 }
				)
			)
			)->set_coordinates(
			x1 => 0, y1 => 0,
			x2 => '100%',
			y2 => '100%',
			)
	);

	$button1->set_focus(1);
	$button1->add_event_listener(
		Curses::Toolkit::EventListener->new(
			accepted_event_class => 'Curses::Toolkit::Event::Key',
			conditional_code     => sub {
				my ($event) = @_;
				$event->{type} eq 'stroke' or return 0;
				$event->{params}{key} eq ' ' or return 0;
			},
			code => sub {
				$hbox->pack_end(
					my $button1 = Curses::Toolkit::Widget::Button->new_with_label('FOO !')->add_event_listener(
						Curses::Toolkit::EventListener->new(
							accepted_event_class => 'Curses::Toolkit::Event::Key',
							conditional_code     => sub {
								my ($event) = @_;
								$event->{type} eq 'stroke' or return 0;
								$event->{params}{key} eq ' ' or return 0;
							},
							code => sub {
								$hbox->pack_end(
									my $button1 = Curses::Toolkit::Widget::Button->new_with_label('BAR !'),
									{ expand => 0 }
								);
							},
						)
					),
					{ expand => 0 }
				);
			},
		)
	);

	POE::Kernel->run();
}

