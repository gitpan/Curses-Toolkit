
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'a modern Curses toolkit',
  'AUTHOR' => 'Damien "dams" Krotkine',
  'BUILD_REQUIRES' => {
    'English' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'IO::Pty::Easy' => '0',
    'Test::Exception' => '0',
    'Test::More' => '0',
    'aliased' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Curses-Toolkit',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Curses::Toolkit',
  'PREREQ_PM' => {
    'Curses' => '0',
    'Data::Dumper' => '0',
    'HTML::Parser' => '0',
    'IO::Pty::Easy' => '0',
    'List::MoreUtils' => '0',
    'List::Util' => '0',
    'Moose' => '0.92',
    'Moose::Util::TypeConstraints' => '0',
    'MooseX::FollowPBP' => '0',
    'MooseX::Has::Sugar' => '0',
    'POE' => '0',
    'Params::Validate' => '0',
    'Tie::Array::Iterable' => '0',
    'UNIVERSAL::require' => '0.13',
    'overload' => '0',
    'parent' => '0'
  },
  'VERSION' => '0.202',
  'test' => {
    'TESTS' => 't/*.t t/object/*.t'
  }
);


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



