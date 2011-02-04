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

use FindBin qw( $Bin );
use lib "$Bin/../../lib";

main() unless caller;

sub main {
    use POE::Component::Curses;

    use Curses::Toolkit::Widget::Window;
    use Curses::Toolkit::Widget::Label;
    use Curses::Toolkit::Widget::Border;

    my $root = POE::Component::Curses->spawn;
    my $window1 =
      Curses::Toolkit::Widget::Window->new->set_name('window')->set_title("label tests 1")
          ->set_coordinates( x1 => 0, y1 => 0, x2 => '100%', y2 => 30 );
    $root->add_window($window1);
    POE::Kernel->run();
}
