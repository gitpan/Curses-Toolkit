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

open STDERR, '>>/dev/null';

main() unless caller;

sub main {

	use Curses::Toolkit;
	use Curses::Toolkit::Widget::Window;
	use Curses::Toolkit::Widget::Border;
	use Curses::Toolkit::Widget::Label;
	use Curses::Toolkit::Widget::VBox;
	use Curses::Toolkit::Widget::HBox;

	local $| = 1;
	open STDERR, '/dev/null';

	my $root = Curses::Toolkit->init_root_window(  )->add_window(
		my $window = Curses::Toolkit::Widget::Window->new()->set_name('main_window')->add_widget(
				my $vbox1 = Curses::Toolkit::Widget::VBox->new()->pack_end(
					my $border2 = Curses::Toolkit::Widget::Border->new()->set_name('border2')->add_widget(
						my $label1 =
							Curses::Toolkit::Widget::Label->new()->set_name('label1')
							->set_text('non-expanding border but a long label that hopefully wraps')
					)
					)->pack_end(
					my $hbox1 = Curses::Toolkit::Widget::HBox->new()->set_name('hbox1')->pack_end(
						my $border4 = Curses::Toolkit::Widget::Border->new()->set_name('border4')->add_widget(
							my $label3 =
								Curses::Toolkit::Widget::Label->new()->set_name('label3')->set_text('expanding border')
						),
						{ expand => 1 }
						)->pack_end(
						my $border5 = Curses::Toolkit::Widget::Border->new()->set_name('border5')->add_widget(
							my $label4 =
								Curses::Toolkit::Widget::Label->new()->set_name('label4')->set_text('expanding border')
						),
						{ expand => 1 }
						),
					{ expand => 1 }

					#                       ),
					)->pack_end(
					my $hbox12 = Curses::Toolkit::Widget::HBox->new()->set_name('hbox1')->pack_end(
						my $border42 = Curses::Toolkit::Widget::Border->new()->set_name('border4')->add_widget(
							my $label32 =
								Curses::Toolkit::Widget::Label->new()->set_name('label3')->set_text('expanding border with fill')
						),
						{ expand => 1, fill => 1 }
						)->pack_end(
						my $border52 = Curses::Toolkit::Widget::Border->new()->set_name('border5')->add_widget(
							my $label42 =
								Curses::Toolkit::Widget::Label->new()->set_name('label4')->set_text('expanding border with fill')
						),
						{ expand => 1, fill => 1 }
						),
					{ expand => 1}

					#                       ),
					)->pack_end(
					my $border6 = Curses::Toolkit::Widget::Border->new()->set_name('border6')->add_widget(
						my $label5 =
							Curses::Toolkit::Widget::Label->new()->set_name('label5')->set_text('expanding border')
					),
					{ expand => 1 }
					)->pack_end(
					my $border7 = Curses::Toolkit::Widget::Border->new()->set_name('border7')->add_widget(
						my $label6 =
							Curses::Toolkit::Widget::Label->new()->set_name('label6')->set_text('non expanding border')
					),
					)
			)->set_coordinates(
			x1 => 0,
			y1 => 0,
			x2 => 40,
			y2 => 30
			)
	)->render()->display();

	sleep 2;

	use Time::HiRes qw(usleep);
	use Curses::Toolkit::Object::Coordinates;
	while (1) {
		foreach ( 1 .. 15 ) {
#			usleep(80000);
			$window->set_coordinates( $window->get_coordinates() + { y2 => 1, x2 => 2 } );
			$root->render()->display();
		}
		foreach ( 1 .. 15 ) {
#			usleep(80000);
			$window->set_coordinates( $window->get_coordinates() + { y2 => -1, x2 => -2 } );
			$root->render()->display();
		}
	}

}
