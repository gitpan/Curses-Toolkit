#!/usr/bin/perl
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

use lib qw(../../lib);
main() unless caller;

sub main {

	use Curses::Toolkit;
	use Curses::Toolkit::Widget::Window;
	use Curses::Toolkit::Widget::Border;
	use Curses::Toolkit::Widget::Label;

	print STDERR "\n";

	# 	my $root = Curses::Toolkit
	# 	  ->init_root_window()
	# 	  ->add_window(
	# 	    my $window = Curses::Toolkit::Widget::Window
	# 		  ->new()
	# 		  ->set_name('main_window')
	# 		  ->set_coordinates(x1 => 0,   y1 => 0,
	# 							x2 => 40,  y2 => 20)
	# 		  ->add_widget(
	# 			my $label1 = Curses::Toolkit::Widget::Label
	# 			->new()
	# 			->set_name('label')
	# 			->set_text('This is just a test with 8 words')
	# 		  )
	# 		)
	# 	  ->render()
	# 	  ->display();


	my $root = Curses::Toolkit->init_root_window(  )->add_window(
		my $window = Curses::Toolkit::Widget::Window->new()->set_name('main_window')->set_coordinates(
			x1 => 0,  y1 => 0,
			x2 => 40, y2 => 20
			)->add_widget(
			my $border1 = Curses::Toolkit::Widget::Border->new()->set_name('border1')->add_widget(
				my $border2 = Curses::Toolkit::Widget::Border->new()->set_name('border2')->add_widget(
					my $border3 = Curses::Toolkit::Widget::Border->new()->set_name('border3')->add_widget(
						my $label1 =
							Curses::Toolkit::Widget::Label->new()->set_text('This is just a test with 8 words')

							#						->set_justify('left')
					)
				)
			)
			)
	)->render()->display();

	# 	use Time::HiRes qw(usleep);
	# 	use Curses::Toolkit::Object::Coordinates;
	# 	while (1) {
	# 		foreach (1..10) {
	# 			usleep(40000);
	# 			$window->set_coordinates($window->get_coordinates() +
	# 									 { x1 => 0, y1 => 0,
	# 									   x2 => 2, y2 => -1, }
	# 									);
	# 			$root
	# 			  ->render()
	# 				->display();
	# 		}
	# 		foreach (1..10) {
	# 			usleep(40000);
	# 			$window->set_coordinates($window->get_coordinates() +
	# 									 { x1 => 0,  y1 => 0,
	# 									   x2 => -2, y2 => 1, }
	# 									);
	# 			$root
	# 			  ->render()
	# 				->display();
	# 		}
	# 	}

	sleep 20;

}