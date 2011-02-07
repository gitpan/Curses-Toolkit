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

package Curses::Toolkit::Widget::Bin;
BEGIN {
  $Curses::Toolkit::Widget::Bin::VERSION = '0.203';
}

# ABSTRACT: a bin widget

use parent qw(Curses::Toolkit::Widget::Container);

use Params::Validate qw(:all);




sub add_widget {
    my $self = shift;
    my ($child_widget) = validate_pos( @_, { isa => 'Curses::Toolkit::Widget' } );
    scalar $self->get_children()
        and die 'there is already a child widget';
    $self->_add_child($child_widget);
    $child_widget->_set_parent($self);

    # because it's a Bin container, needs to take care of rebuilding coordinates
    # from top to bottom
    $self->rebuild_all_coordinates();
    return $self;
}



sub remove_widget {
    my ($self) = @_;
    my @children = ();

    $self->{children} = Tie::Array::Iterable->new(@children);
    return $self;
}

sub _rebuild_children_coordinates {
    my ($self)          = @_;
    my $available_space = $self->_get_available_space();
    my ($child_widget)  = $self->get_children();
    defined $child_widget or return;

    # Given the available space, how much does the child widget want ?
    my $child_space = $child_widget->get_desired_space( $available_space->clone() );

    # Make sure it's not bigger than what is available
    $child_space->restrict_to($available_space);

    # 		# Force the child space to be as large as the available space
    # 		$child_space->set(x2 => $available_space->get_x2() );
    # At the end, we grant it this space
    $child_widget->_set_relatives_coordinates($child_space);
    $child_widget->can('_rebuild_children_coordinates')
        and $child_widget->_rebuild_children_coordinates();
    return $self;
}

1;

__END__
=pod

=head1 NAME

Curses::Toolkit::Widget::Bin - a bin widget

=head1 VERSION

version 0.203

=head1 DESCRIPTION

This widget can contain 0 or 1 other widget.

=head1 CONSTRUCTOR

=head2 new

  input : none
  output : a Curses::Toolkit::Widget::Bin

=head1 METHODS

=head2 add_widget

Add a widget as unique child. Only one widget can be added. Fails if a child
already exists. Call remove_widget() if you want to call add_widget() again. To
know if there is already a widget, call get_children().

The added child widget takes all the available space.

  input  : the child widget
  output : the current widget (not the child widget)

=head2 remove_widget

Removes the child widget.

  input  : none
  output : the current widget (not the child widget)

=head1 AUTHOR

Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

