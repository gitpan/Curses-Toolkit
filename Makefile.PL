
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Curses-Toolkit',
  NAME      => 'Curses::Toolkit',
  AUTHOR    => "Damien\ \"dams\"\ Krotkine",
  ABSTRACT  => "a\ modern\ Curses\ toolkit",
  VERSION   => '0.100320',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "FindBin" => '0',
    "List::Util" => '0',
    "File::Find" => '0',
    "Curses::UI" => '0',
    "List::MoreUtils" => '0',
    "Moose" => '0.92',
    "parent" => '0',
    "English" => '0',
    "Tie::Array::Iterable" => '0',
    "overload" => '0',
    "Curses" => '0',
    "Test::More" => '0',
    "Params::Validate" => '0',
    "HTML::Parser" => '0',
    "MooseX::FollowPBP" => '0',
    "UNIVERSAL::require" => '0.13',
    "POE" => '0',
  },
  test => {TESTS => 't/*.t'}
);

