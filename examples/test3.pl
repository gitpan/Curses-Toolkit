#!/usr/bin/perl
# 
# This file is part of Curses-Toolkit
# 
# This software is copyright (c) 2008 by Damien "dams" Krotkine.
# 
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
# 

use Tie::Array::Iterable;
  
my @array = (1, 2, 3);

my $iterarray = new Tie::Array::Iterable( @array );

print Dumper($iterarray); use Data::Dumper;

push @$iterarray, 5;

print Dumper($iterarray); use Data::Dumper;

#   for( my $iter = $iterarray->start() ; !$iter->at_end() ; $iter->next() ) {
#         print $iter->index(), " : ", $iter->value();
#         if ( $iter->value() == 3 ) {
#                 unshift @$iterarray, (11..15); 
#         }
#   }