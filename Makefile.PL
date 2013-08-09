
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "a modern Curses toolkit",
  "AUTHOR" => "Damien \"dams\" Krotkine",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Curses-Toolkit",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Curses::Toolkit",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Curses" => 0,
    "HTML::Parser" => 0,
    "List::MoreUtils" => 0,
    "List::Util" => 0,
    "POE" => 0,
    "POE::Session" => 0,
    "POE::Wheel::Curses" => 0,
    "Params::Validate" => 0,
    "Tie::Array::Iterable" => 0,
    "UNIVERSAL::require" => "0.13",
    "overload" => 0,
    "parent" => 0,
    "relative" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "IO::Pty::Easy" => 0,
    "Test::Exception" => 0,
    "Test::More" => "0.94",
    "aliased" => 0
  },
  "VERSION" => "0.209",
  "test" => {
    "TESTS" => "t/*.t t/object/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



