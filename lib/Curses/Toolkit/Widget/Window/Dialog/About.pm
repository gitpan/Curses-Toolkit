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

package Curses::Toolkit::Widget::Window::Dialog::About;
our $VERSION = '0.100320';


# ABSTRACT: an about dialog window

use parent qw(Curses::Toolkit::Widget::Window::Dialog);

1;



=pod

=head1 NAME

Curses::Toolkit::Widget::Window::Dialog::About - an about dialog window

=head1 VERSION

version 0.100320

=head1 SYNOPSIS

    # FIXME: not yet implemented

=head1 DESCRIPTION

This about window offers a simple way to display information about a program
like its logo, name, copyright, website and license. It is also possible to
give credits to the authors, documenters, translators and artists who have
worked on the program. An about dialog is typically opened when the user
selects the About option from the Help menu. All parts of the dialog are
optional.

=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 



__END__