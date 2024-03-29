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

package Curses::Toolkit::Widget::HBox;
{
  $Curses::Toolkit::Widget::HBox::VERSION = '0.211';
}

# ABSTRACT: an horizontal box widget

use parent qw(Curses::Toolkit::Widget::Container);

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);

use Curses::Toolkit::Object::Coordinates;

our @EXPORT_OK = qw(HBox);
our %EXPORT_TAGS = (all => [qw(HBox)]);

sub HBox { 'Curses::Toolkit::Widget::HBox' }




sub pack_start {
    my $self = shift;
    my ( $child_widget, $options ) = validate_pos(
        @_,
        { isa  => 'Curses::Toolkit::Widget' },
        { type => HASHREF, default => {} },
    );
    my @array   = ($options);
    my %options = validate(
        @array,
        {   expand  => { type => BOOLEAN, default => 0 },
            fill    => { type => BOOLEAN, default => 0 },
            padding => { type => SCALAR,  default => 0, regex => qr/^\d+$/ },
        }
    );
    $self->_add_child_at_beginning($child_widget);

    #	unshift @{$self->{children}}, $child_widget;
    $child_widget->_set_parent($self);
    $child_widget->set_property( packing => \%options );
    $self->rebuild_all_coordinates();
    return $self;
}

sub pack_end {
    my $self = shift;
    my ( $child_widget, $options ) = validate_pos(
        @_,
        { isa  => 'Curses::Toolkit::Widget' },
        { type => HASHREF, default => {} },
    );
    my @array   = ($options);
    my %options = validate(
        @array,
        {   expand  => { type => BOOLEAN, default => 0 },
            fill    => { type => BOOLEAN, default => 0 },
            padding => { type => SCALAR,  default => 0, regex => qr/^\d+$/ },
        }
    );
    $self->_add_child_at_end($child_widget);

    #	push @{$self->{children}}, $child_widget;
    $child_widget->_set_parent($self);
    $child_widget->set_property( packing => \%options );
    $self->rebuild_all_coordinates();
    return $self;
}

sub _rebuild_children_coordinates {
    my ($self) = @_;
    my $available_space = $self->_get_available_space();

    my @children_widths;
    my @children_padding;

    my $desired_space   = $available_space->clone();
    my $remaining_space = $available_space->clone();

    # first, compute how large all the non expanding children are
    my @children = $self->get_children();

    my $width = 0;
    my $idx   = 0;
    foreach my $child (@children) {
        if ( $child->get_property( 'packing', 'expand' ) ) {
            $idx++;
        } else {
            my $space = $child->get_minimum_space($remaining_space);
            my $w     = $space->width();
            $width += $w;
            $remaining_space->subtract( { x2 => $w } );
            $children_widths[$idx] = $w;
            $children_padding[$idx] = { before => 0, after => 0 };
            $idx++;
        }
    }

    # add to it the width of the expanding children, restricted
    my $count = scalar( grep { $_->get_property( 'packing', 'expand' ) } @children );

    $idx = 0;
    foreach my $child (@children) {
        if ( !$child->get_property( 'packing', 'expand' ) ) {
            $idx++;
        } else {
            my $avg_width = int( $remaining_space->width() / $count );
            my $avg_space = $remaining_space->clone();
            $avg_space->set( x2 => $avg_space->get_x1() + $avg_width );
            my $space = $child->get_desired_space($avg_space);
            my $w     = $space->width();
            if ($w < $avg_width) {
                if ($child->get_property(packing => 'fill')) {
                    $w = $avg_width;
                    $children_padding[$idx] = { before => 0, after => 0 };
                } else {
                    my $p = int(($avg_width - $w) / 2);
                    $children_padding[$idx] = { before => $p, after => ($avg_width-$w-$p) };
                }
            }
            $children_padding[$idx]{before} ||= 0;
            $children_padding[$idx]{after} ||= 0;
            $remaining_space->subtract( { x2 => $w + $children_padding[$idx]{before} + $children_padding[$idx]{after} } );
            $width += $w;
            $children_widths[$idx] = $w;
            $count--;
            $idx++;
        }
    }

    $idx = 0;
    my $x1 = 0;
    my $x2 = 0;
    foreach my $child (@children) {
        my $child_space = $available_space->clone();
        $x1 += $children_padding[$idx]{before};
        $x2 = $x1 + $children_widths[$idx];
        $child_space->set( x1 => $x1, x2 => $x2 );
        $child_space->restrict_to($available_space);
        $child->_set_relatives_coordinates($child_space);
        $child->can('_rebuild_children_coordinates')
            and $child->_rebuild_children_coordinates();

        $x1 = $x2;
        $x1 += $children_padding[$idx]{after};
        $idx++;
    }

    return $self;
}


sub get_desired_space {
    my ( $self, $available_space ) = @_;

    defined $available_space
      or return $self->get_minimum_space();

    my $desired_space   = $available_space->clone();

return $desired_space;

#     my $remaining_space = $available_space->clone();

#     # first, compute how large all the non expanding children are
#     my @children = $self->get_children();
#     my $width    = 0;
#     foreach my $child ( grep { !$_->get_property( 'packing', 'expand' ) } @children ) {
#         my $space = $child->get_minimum_space($remaining_space);
#         my $w     = $space->width();
#         $width += $w;
#         $remaining_space->subtract( { x2 => $w } );
#     }

#     # add to it the width of the expanding children, restricted
#     my @expanding_children = grep { $_->get_property( 'packing', 'expand' ) } @children;

#     my $count = @expanding_children;
#     foreach my $child (@expanding_children) {
#         my $avg_width = int( $remaining_space->width() / $count );
#         my $avg_space = $remaining_space->clone();
#         $avg_space->set( x2 => $avg_space->get_x1() + $avg_width );
#         my $space = $child->get_desired_space($avg_space);
#         my $w     = $space->width();
#         $remaining_space->subtract( { x2 => $w } );
#         $width += $w;
#         $count--;
#     }

#     $desired_space->set( x2 => $desired_space->get_x1() + $width );

#     return $desired_space;

}


sub get_minimum_space {
    my ( $self, $available_space ) = @_;

    my @children = $self->get_children();
    # compute how high all the children are
    my $width    = 0;
    my $height   = 0;

    if (! defined $available_space) {
        foreach my $child (@children) {
            my $space = $child->get_minimum_space();
            my $w     = $space->width();
            $width += $w;
            use List::Util qw(max);
            $height = max $height, $space->height();
        }
        return Curses::Toolkit::Object::Coordinates->new(
                   x1 => 0, y1 => 0,
                   x2 => $width, y2 => $height );
    }

    my $minimum_space   = $available_space->clone();
    my $remaining_space = $available_space->clone();

    foreach my $child (@children) {
        my $space = $child->get_minimum_space($remaining_space);
        my $w     = $space->width();
        $width += $w;
        use List::Util qw(max);
        $height = max $height, $space->height();
        $remaining_space->subtract( { x2 => $w } );
    }

    $minimum_space->set( x2 => $minimum_space->get_x1() + $width, y2 => $minimum_space->get_y1() + $height );

    return $minimum_space;

}

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Widget::HBox - an horizontal box widget

=head1 VERSION

version 0.211

=head1 DESCRIPTION

This widget can contain 0 or more widgets. The children are packed horizontally.

=head1 CONSTRUCTOR

=head2 new

  input : none
  output : a Curses::Toolkit::Widget::HBox

=head1 METHODS

=head2 pack_start

Add a widget in the horizontal box, at the start of the box. You can call
pack_start multiple time to add more widgets.

  input  : the child widget
           optionally, a hash containing options
  output : the current widget (not the child widget)

The hash containing options can contain :

expand : TRUE if the new child is to be given extra space allocated to box.
The extra space will be divided evenly between all children of box that use
this option

fill : TRUE if space given to child by the expand option is actually
allocated to child, rather than just padding it. This parameter has no effect
if expand is set to FALSE. A child is always allocated the full height of a
GtkHBox and the full width of a GtkVBox. This option affects the other
dimension

padding : extra space in pixels to put between this child and its neighbors,
over and above the global amount specified by "spacing" property. If child is
a widget at one of the reference ends of box, then padding pixels are also
put between child and the reference edge of box

=head2 get_desired_space

Given a coordinate representing the available space, returns the space desired

  input : a Curses::Toolkit::Object::Coordinates object
  output : a Curses::Toolkit::Object::Coordinates object

=head2 get_minimum_space

Given a coordinate representing the available space, returns the minimum space
needed to properly display itself

  input : a Curses::Toolkit::Object::Coordinates object
  output : a Curses::Toolkit::Object::Coordinates object

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
