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

use FindBin qw( $Bin );
use lib "$Bin/../../lib";

use POE::Component::Curses;
use Curses::Toolkit::Widget::Window;
use Curses::Toolkit::Widget::Button;

# spawn a root window
my $root = POE::Component::Curses->spawn();
  # adds some widget
  $root->add_window(
      my $window = Curses::Toolkit::Widget::Window
        ->new()
        ->set_name('main_window')
        ->add_widget(
          my $button = Curses::Toolkit::Widget::Button
            ->new_with_label('Click Me to quit')
            ->set_name('my_button')
            ->signal_connect(clicked => sub { exit(0); })
        )
        ->set_coordinates(x1 => 0,   y1 => 0,
                          x2 => '100%',
                          y2 => '100%',
                         )
  );

# start main loop
POE::Kernel->run();
