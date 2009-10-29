
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Curses-Toolkit',
  NAME      => 'Curses::Toolkit',
  AUTHOR    => "Damien\ \"dams\"\ Krotkine",
  ABSTRACT  => "a\ modern\ Curses\ toolkit",
  VERSION   => '0.093020',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "English" => '0',
    "parent" => '0',
    "FindBin" => '0',
    "Tie::Array::Iterable" => '0',
    "overload" => '0',
    "Curses" => '0',
    "Test::More" => '0',
    "List::Util" => '0',
    "Params::Validate" => '0',
    "File::Find" => '0',
    "Curses::UI" => '0',
    "UNIVERSAL::require" => '0.13',
    "List::MoreUtils" => '0',
    "POE" => '0',
  },
  test => {TESTS => 't/*.t'}
);

