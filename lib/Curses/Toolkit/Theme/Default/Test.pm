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

package Curses::Toolkit::Theme::Default::Test;
{
  $Curses::Toolkit::Theme::Default::Test::VERSION = '0.209';
}

# ABSTRACT: widget test theme

use parent qw(Curses::Toolkit::Theme::Default::Color);

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);
#use Curses;



my $output_writer;
sub set_writer {
    my ($class, $writer) = @_;
    $output_writer = $writer;
}


sub new {
    my $class = shift;
    my $widget = shift;
    my $self = $class->SUPER::new($widget);
    $self->{output_writer} = $output_writer || sub { print STDERR "@_\n"; };
    $self->{curses_mockup} = Curses::Toolkit::Theme::Default::Test::CursesMockup->new( { output_writer => $output_writer } );

    return $self;
}

# override curses handler method

sub _get_curses_handler {
    my ($self) = @_;
    return $self->{curses_mockup};
}


sub default_fgcolor { 'white' }
sub default_bgcolor { 'black' }

sub ULCORNER { '+'; }
sub LLCORNER { '+'; }
sub URCORNER { '+'; }
sub LRCORNER { '+'; }
sub HLINE    { '-'; }
sub VLINE    { '|'; }


# the values of this theme
sub HLINE_NORMAL  {  }
sub HLINE_FOCUSED {  }
sub HLINE_CLICKED {  }

sub VLINE_NORMAL  {  }
sub VLINE_FOCUSED {  }
sub VLINE_CLICKED {  }

sub CORNER_NORMAL  {  }
sub CORNER_FOCUSED {  }
sub CORNER_CLICKED {  }

sub STRING_NORMAL  { }
sub STRING_FOCUSED { }
sub STRING_CLICKED { }

sub VSTRING_NORMAL  { }
sub VSTRING_FOCUSED { }
sub VSTRING_CLICKED { }

sub TITLE_NORMAL  { }
sub TITLE_FOCUSED { }
sub TITLE_CLICKED { }

sub RESIZE_NORMAL  { }
sub RESIZE_FOCUSED { }
sub RESIZE_CLICKED { }

sub BLANK_NORMAL  { }
sub BLANK_FOCUSED { }
sub BLANK_CLICKED { }


package Curses::Toolkit::Theme::Default::Test::CursesMockup;
{
  $Curses::Toolkit::Theme::Default::Test::CursesMockup::VERSION = '0.209';
}

sub new { bless { %{$_[1]} }, $_[0] }
sub attrset { }
sub attron { }
sub attroff { }

sub hline  { $_[0]->{output_writer}->($_[2], $_[1], $_[3] x $_[4]) }
sub vline  { $_[0]->{output_writer}->($_[2], $_, $_[3]) foreach ( $_[1] .. $_[1]+$_[4]-1) }
sub addch  { $_[0]->{output_writer}->($_[2], $_[1], $_[3])  }
sub addstr { $_[0]->{output_writer}->($_[2], $_[1], $_[3])  }

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Theme::Default::Test - widget test theme

=head1 VERSION

version 0.209

=head1 DESCRIPTION

This theme is used for testing : it doesn't mess too much with the terminal,
and it provides the output as string, that can be used for checking test
results.

=head1 CLASS METHOD

=head2 set_writer

=head1 CONSTRUCTOR

=head2 new

the coderef will be called with 3 arguments : $x, $y, and the data to be outputed.

  input : a Curses::Toolkit::Widget
  output : a Curses::Toolkit::Theme::Default::Test object

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
