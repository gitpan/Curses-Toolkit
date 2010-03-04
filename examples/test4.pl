#!/usr/bin/perl
# 
# This file is part of Curses-Toolkit
# 
# This software is copyright (c) 2008 by Damien "dams" Krotkine.
# 
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
# 

use Curses;

use Curses;
my $curses = Curses->new();

my @list = ( ACS_BBSS, ACS_BLOCK, ACS_BOARD, ACS_BSBS, ACS_BSSB, ACS_BSSS, ACS_BTEE,
	ACS_BULLET, ACS_CKBOARD, ACS_DARROW, ACS_DEGREE, ACS_DIAMOND,  ACS_GEQUAL,
	ACS_HLINE,  ACS_LANTERN, ACS_LARROW, ACS_LEQUAL, ACS_LLCORNER, ACS_LRCORNER,
	ACS_LTEE, ACS_NEQUAL, ACS_PI, ACS_PLMINUS, ACS_PLUS, ACS_RARROW, ACS_RTEE,
	ACS_S1,       ACS_S3,   ACS_S7,   ACS_S9,       ACS_SBBS, ACS_SBSB,   ACS_SBSS, ACS_SSBB,
	ACS_SSBS,     ACS_SSSB, ACS_SSSS, ACS_STERLING, ACS_TTEE, ACS_UARROW, ACS_ULCORNER,
	ACS_URCORNER, ACS_VLINE
);

my @name = qw(ACS_BBSS ACS_BLOCK ACS_BOARD ACS_BSBS ACS_BSSB ACS_BSSS ACS_BTEE
	ACS_BULLET ACS_CKBOARD ACS_DARROW ACS_DEGREE ACS_DIAMOND ACS_GEQUAL
	ACS_HLINE ACS_LANTERN ACS_LARROW ACS_LEQUAL ACS_LLCORNER ACS_LRCORNER
	ACS_LTEE ACS_NEQUAL ACS_PI ACS_PLMINUS ACS_PLUS ACS_RARROW ACS_RTEE
	ACS_S1 ACS_S3 ACS_S7 ACS_S9 ACS_SBBS ACS_SBSB ACS_SBSS ACS_SSBB
	ACS_SSBS ACS_SSSB ACS_SSSS ACS_STERLING ACS_TTEE ACS_UARROW ACS_ULCORNER
	ACS_URCORNER ACS_VLINE);
my $y = 0;
foreach my $i ( 0 .. @list - 1 ) {
	$curses->addch( $y, $x, $list[$i] );
	$curses->addstr( $y, $x + 2, $name[$i] );

	#	$x++;
	$y++;

	#	$x % 50 or do { $x = 0, $y++; };
	$curses->refresh();
}

sleep 5;