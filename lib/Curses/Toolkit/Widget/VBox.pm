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

package Curses::Toolkit::Widget::VBox;
{
  $Curses::Toolkit::Widget::VBox::VERSION = '0.211';
}

# ABSTRACT: a vertical box widget

use parent qw(Curses::Toolkit::Widget::Container);

use Params::Validate qw(SCALAR ARRAYREF HASHREF CODEREF GLOB GLOBREF SCALARREF HANDLE BOOLEAN UNDEF validate validate_pos);

our @EXPORT_OK = qw(VBox);
our %EXPORT_TAGS = (all => [qw(VBox)]);

sub VBox { 'Curses::Toolkit::Widget::VBox' }




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

    my @children_heights;
    my @children_padding;

    my $desired_space   = $available_space->clone();
    my $remaining_space = $available_space->clone();

    # first, compute how high all the non expanding children are
    my @children = $self->get_children();

    my $height = 0;
    my $idx    = 0;
    foreach my $child (@children) {
        if ( $child->get_property( 'packing', 'expand' ) ) {
            $idx++;
        } else {
            my $space = $child->get_minimum_space($remaining_space);
            my $h     = $space->height();
            $height += $h;
            $remaining_space->subtract( { y2 => $h } );
            $children_heights[$idx] = $h;
            $children_padding[$idx] = { before => 0, after => 0 };
            $idx++;
        }
    }


    # add to it the height of the expanding children, restricted
    my $count = scalar( grep { $_->get_property( 'packing', 'expand' ) } @children );

    $idx = 0;
    foreach my $child (@children) {
        if ( !$child->get_property( 'packing', 'expand' ) ) {
            $idx++;
        } else {
            my $avg_height = int( $remaining_space->height() / $count );
            my $avg_space  = $remaining_space->clone();
            $avg_space->set( y2 => $avg_space->get_y1() + $avg_height );
            my $space = $child->get_desired_space($avg_space);
            my $h     = $space->height();
            if ($h < $avg_height) {
                if ($child->get_property(packing => 'fill')) {
                    $h = $avg_height;
                    $children_padding[$idx] = { before => 0, after => 0 };
                } else {
                    my $p = int(($avg_height - $h) / 2);
                    $children_padding[$idx] = { before => $p, after => ($avg_height-$h-$p) };
                }
            }
            $children_padding[$idx]{before} ||= 0;
            $children_padding[$idx]{after} ||= 0;
            $remaining_space->subtract( { y2 => $h + $children_padding[$idx]{before} + $children_padding[$idx]{after} } );
            $height += $h;
            $children_heights[$idx] = $h;
            $count--;
            $idx++;
        }
    }

    $idx = 0;
    my $y1 = 0;
    my $y2 = 0;
    foreach my $child (@children) {
        my $child_space = $available_space->clone();
        $y1 += $children_padding[$idx]{before};
        $y2 = $y1 + $children_heights[$idx];
        $child_space->set( y1 => $y1, y2 => $y2 );
        $child_space->restrict_to($available_space);
        $child->_set_relatives_coordinates($child_space);
        $child->can('_rebuild_children_coordinates')
            and $child->_rebuild_children_coordinates();

        $y1 = $y2;
        $y1 += $children_padding[$idx]{after};
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

#     # first, compute how high all the non expanding children are
#     my @children = $self->get_children();
#     my $height   = 0;
#     foreach my $child ( grep { !$_->get_property( 'packing', 'expand' ) } @children ) {
#         my $space = $child->get_minimum_space($remaining_space);
#         my $h     = $space->height();
#         $height += $h;
#         $remaining_space->subtract( { y2 => $h } );
#     }

#     # add to it the height of the expanding children, restricted
#     my @expanding_children = grep { $_->get_property( 'packing', 'expand' ) } @children;

#     my $count = @expanding_children;
#     foreach my $child (@expanding_children) {
#         my $avg_height = int( $remaining_space->height() / $count );
#         my $avg_space  = $remaining_space->clone();
#         $avg_space->set( y2 => $avg_space->get_y1() + $avg_height );
#         my $space = $child->get_desired_space($avg_space);
#         my $h     = $space->height();
#         $remaining_space->subtract( { y2 => $h } );
#         $height += $h;
# #        $count--;
#     }

#     $desired_space->set( y2 => $desired_space->get_y1() + $height );

#     return $desired_space;

}


sub get_minimum_space {
    my ( $self, $available_space ) = @_;

    my @children = $self->get_children();

    # compute how high all the children are
    my $height   = 0;
    my $width    = 0;

    if (! defined $available_space) {
        foreach my $child (@children) {
            my $space = $child->get_minimum_space();
            my $h     = $space->width();
            $height += $h;
            use List::Util qw(max);
            $width = max $width, $space->width();
        }
        return Curses::Toolkit::Object::Coordinates->new(
                   x1 => 0, y1 => 0,
                   x2 => $width, y2 => $height );
    }

    my $minimum_space   = $available_space->clone();
    my $remaining_space = $available_space->clone();

    foreach my $child (@children) {
        my $space = $child->get_minimum_space($remaining_space);
        my $h     = $space->height();
        $height += $h;
        use List::Util qw(max);
        $width = max $width, $space->width();
        $remaining_space->subtract( { y2 => $h } );
    }

    $minimum_space->set(
        y2 => $minimum_space->get_y1() + $height,
        x2 => $minimum_space->get_x1() + $width,
    );

    return $minimum_space;

}

1;

__END__

=pod

=head1 NAME

Curses::Toolkit::Widget::VBox - a vertical box widget

=head1 VERSION

version 0.211

=head1 DESCRIPTION

This widget can contain 0 or more widgets. The children are packed vertically.

=head1 CONSTRUCTOR

=head2 new

  input : none
  output : a Curses::Toolkit::Widget::VBox

=head1 METHODS

=head2 pack_start

Add a widget in the vertical box, at the start of the box. You can call
pack_start multiple time to add more widgets.

  input  : the child widget
           optionally, a hash containing options
  output : the current widget (not the child widget)

The hash containing options can contain :

expand : if set to true, the new child will be given extra space allocated to box.
The extra space will be divided evenly between all children of box that use
this option

fill : if set to true, the space given to child by the expand option is actually
allocated to child, rather than just padding it. This parameter has no effect
if expand is set to false. A child is always allocated the full height of a
GtkHBox and the full width of a GtkVBox. This option affects the other
dimension

padding : NOT SUPPORTED YET. extra space in pixels to put between this child and its neighbors,
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
