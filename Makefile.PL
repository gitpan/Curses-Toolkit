
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Curses-Toolkit',
  NAME      => 'Curses::Toolkit',
  AUTHOR    => "Damien\ \"dams\"\ Krotkine",
  ABSTRACT  => "a\ modern\ Curses\ toolkit",
  VERSION   => '0.100680',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "MooseX::Has::Sugar" => '0',
    "FindBin" => '0',
    "Moose::Util::TypeConstraints" => '0',
    "List::Util" => '0',
    "File::Find" => '0',
    "Curses::UI" => '0',
    "Moose::Meta::Attribute::Custom::Trait::Chained" => '1.000',
    "File::Spec::Functions" => '0',
    "List::MoreUtils" => '0',
    "Moose" => '0.92',
    "File::Find::Rule" => '0',
    "English" => '0',
    "Term::ANSIColor" => '0',
    "parent" => '0',
    "Tie::Array::Iterable" => '0',
    "overload" => '0',
    "Curses" => '0',
    "Test::More" => '0',
    "Params::Validate" => '0',
    "HTML::Parser" => '0',
    "MooseX::FollowPBP" => '0',
    "Path::Class" => '0',
    "UNIVERSAL::require" => '0.13',
    "Cwd" => '0',
    "POE" => '0',
  },
  test => {TESTS => 't/*.t'}
);

