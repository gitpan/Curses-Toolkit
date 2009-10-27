# 
# This file is part of Curses-Toolkit
# 
# This software is copyright (c) 2008 by Damien "dams" Krotkine.
# 
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
# 
use warnings;
use strict;

package Curses::Toolkit;
our $VERSION = '0.093000';


# ABSTRACT: a modern Curses toolkit

use Params::Validate qw(:all);


sub init_root_window {
    my $class = shift;
    
    my %params = validate(@_, { clear => { type => BOOLEAN,
										   default => 1,
										 },
								theme_name => { type => SCALAR,
												optional => 1,
											   },
								mainloop => { optional => 1
												},
							  }
                         );

    # get the Curses handler
    use Curses;
    my $curses_handler = Curses->new();

# already done ?
# 	raw();
# 	cbreak();
# 	noecho();
# 	$curses_handler->keypad(1);

	if (has_colors) {
		start_color();
# 		print STDERR "color is supported\n";
# 		print STDERR "colors number : " . COLORS . "\n";
# 		print STDERR "colors pairs : " . COLOR_PAIRS . "\n";
# 		print STDERR "can change colors ? : " . Curses::can_change_color() . "\n";

#  	my $pair_nb = 1;
#  	foreach my $bg_nb (0..COLORS()-1) {
#  		foreach my $fg_nb (0..COLORS()-1) {
#  #			print STDERR "color pairing : $pair_nb, $fg_nb, $bg_nb \n";
#  			init_pair($pair_nb, $fg_nb, $bg_nb);
#  			$pair_nb++;
#  		}
#  	}

# 	my $curses = $curses_handler;
# 	foreach my $x (0..7) {
# 		$curses->addstr(0, ($x+1)*3, $x);
# 	}
# 	foreach my $y (0..7) {
# 		$curses->addstr($y+1, 0, $y);
# 	}

# 	my $pair = 1;
# 	foreach my $x (0..7) {
# 		foreach my $y (0..7) {
# 			COLOR_PAIR($pair);
# 			$curses->attrset(COLOR_PAIR($pair));
# 			$curses->addstr($y+1, ($x+1)*3, "$x$y");
# 			$pair++;
# 		}
# 	}

	}

    eval { Curses->can('NCURSES_MOUSE_VERSION') && (NCURSES_MOUSE_VERSION() >= 1 ) };

	my $old_mouse_mask;
	my $mouse_mask = mousemask(ALL_MOUSE_EVENTS | REPORT_MOUSE_POSITION, $old_mouse_mask); 

    # curses basic init
#    Curses::noecho();
#    Curses::cbreak();
#    curs_set(0);
#    Curses::leaveok(1);

#$curses_handler->erase();

    # erase the window if asked.
#    print STDERR Dumper($params{clear}); use Data::Dumper;
#    $params{clear} and $curses_handler->erase();
    
#    use Curses::Toolkit::Widget::Container;
#    my $container = Curses::Toolkit::Widget::Warper->new();

	use Curses::Toolkit::Theme::Default;
	use Curses::Toolkit::Theme::Default::Color::Yellow;
	use Curses::Toolkit::Theme::Default::Color::Pink;
	use Tie::Array::Iterable;
#	$params{theme_name} ||= (has_colors() ? 'Curses::Toolkit::Theme::Default::Color::Pink' : 'Curses::Toolkit::Theme::Default');
	$params{theme_name} ||= (has_colors() ? 'Curses::Toolkit::Theme::Default::Color::Yellow' : 'Curses::Toolkit::Theme::Default');
	my @windows = ();
    my $self = bless { initialized => 1, 
                       curses_handler => $curses_handler,
                       windows => Tie::Array::Iterable->new( @windows ),
					   theme_name => $params{theme_name},
					   mainloop => $params{mainloop},
					   last_stack => 0,
					   event_listeners => [],
                     }, $class;
	$self->_recompute_shape();

	use Curses::Toolkit::EventListener;
	# add a default listener that listen to any Shape event
	$self->add_event_listener(
		Curses::Toolkit::EventListener->new(
			accepted_events => {
				'Curses::Toolkit::Event::Shape' => sub { 1; },
			},
			code => sub {
				my ($screen_h, $screen_w);
				$self->_recompute_shape();
				# for now we rebuild all coordinates
				foreach my $window ( $self->get_windows() ) {
					$window->rebuild_all_coordinates();
				}
			},
		)
	);
	$self->add_event_listener(
		Curses::Toolkit::EventListener->new(
			accepted_events => {
				'Curses::Toolkit::Event::Key' => sub { 
					my ($event) = @_;
					$event->{type} eq 'stroke' or return 0;
					lc $event->{params}{key} eq 'q' or return 0;
				},
			},
			code => sub {
				exit;
			},
		)
	);
	# key listener for TAB
	$self->add_event_listener(
		Curses::Toolkit::EventListener->new(
			accepted_events => {
				'Curses::Toolkit::Event::Key' => sub {
					my ($event) = @_;
					$event->{type} eq 'stroke' or return 0;
					$event->{params}{key} eq 'j' || $event->{params}{key} eq '<^I>' or return 0;
				},
			},
			code => sub {
				my $focused_widget = $self->get_focused_widget();
				if (defined $focused_widget) {
					my $next_focused_widget = $focused_widget->get_next_focused_widget();
					defined $next_focused_widget and 
					  $next_focused_widget->set_focus(1);
				} else {
					my $focused_window = $self->get_focused_window();
					my $next_focused_widget = $focused_window->get_next_focused_widget();
					defined $next_focused_widget and 
					  $next_focused_widget->set_focus(1);
				}
			},
		)
	);

#$self->{window_iterator}
    return $self;
}

# destroyer
DESTROY {
    my ($obj) = @_;
    # ending Curses
    ref($obj) eq 'Curses::Toolkit' and
	  Curses::endwin;
}



sub get_theme_name {
	my ($self) = @_;
	return $self->{theme_name};
}



sub add_event_listener {
	my $self = shift;
	my ($listener) = validate_pos( @_, { isa => 'Curses::Toolkit::EventListener' } );
	push @{$self->{event_listeners}}, $listener;
	return $self;
}


sub get_event_listeners {
	my ($self) = @_;
	return @{$self->{event_listeners}};
}


sub get_focused_widget {
	my ($self) = @_;
	my $window = $self->get_focused_window();
	defined $window or return;
	return $window->get_focused_widget();
}


sub get_focused_window {
	my ($self) = @_;
	my @windows = $self->get_windows();
	@windows or return;
	my $window = (sort { $b->get_property(window => 'stack') <=> $a->get_property(window => 'stack') } @windows)[0];
	return $window;
}


sub set_mainloop {
	my $self = shift;
	my ($mainloop) = validate_pos( @_, { optional => 0 } );
	$self->{mainloop} = $mainloop;
	return $self;
}


sub get_mainloop {
	my ($self) = @_;
	return $self->{mainloop};
}


sub get_shape {
	my ($self) = @_;
	return $self->{shape};
}


sub add_window {
    my $self = shift;
    my ($window) = validate_pos( @_, { isa => 'Curses::Toolkit::Widget::Window' } );
	$window->_set_curses_handler($self->{curses_handler});
	$window->set_theme_name($self->{theme_name});
	$window->set_root_window($self);
	$self->{last_stack}++;
	$window->set_property(window => 'stack', $self->{last_stack});
	# in case the window has proportional coordinates depending on the root window
	# TODO : do that only if window has proportional coordinates, not always
	$window->rebuild_all_coordinates();
    push @{$self->{windows}}, $window;
	$self->{window_iterator} ||= $self->{windows}->forward_from(0);
	$self->needs_redraw();
	return $self;
}


sub needs_redraw {
	my ($self) = @_;
	my $mainloop = $self->get_mainloop();
	defined $mainloop or return $self;
	$mainloop->needs_redraw();
	return $self;
}


sub get_windows {
    my ($self) = @_;
    return @{$self->{windows}};
}


sub set_modal_widget {
	my $self = shift;
    my ($widget) = validate_pos( @_, { isa => 'Curses::Toolkit::Widget' } );
	$self->{_modal_widget} = $widget;
	return $self;
}


sub unset_modal_widget {
	my $self = shift;
	$self->{_modal_widget} = undef;
	return;
}


sub get_modal_widget {
	my ($self) = @_;

	my $modal_widget = $self->{_modal_widget};
	defined $modal_widget or return;
	return $modal_widget;
}


sub show_all {
    my ($self) = @_;
    foreach my $window ($self->get_windows()) {
        $window->show_all();
    }
    return $self;
}



sub render {
    my ($self) = @_;
	$self->{curses_handler}->erase();
	foreach my $window (sort { $a->get_property(window => 'stack') <=> $b->get_property(window => 'stack') } $self->get_windows()) {
		$window->render();
	}
	return $self;
}


sub display {
	my ($self) = @_;
	$self->{curses_handler}->refresh();
	return $self;
}


sub dispatch_event {
	my $self = shift;
	my ($event, $widget, $dont_dispatch_further) = 
	  validate_pos(@_, { isa => 'Curses::Toolkit::Event' },
				       { isa => 'Curses::Toolkit::Widget', optional => 1 },
				       { type => BOOLEAN, optional => 1 },
				  );

	if (! defined $widget) {
		$widget = $self->get_modal_widget();
		defined $widget and $self->unset_modal_widget();
	}
	$widget ||= $event->get_matching_widget();
	defined $widget or return;

	while ( 1 ) {
		foreach my $listener (grep { $_->is_enabled() } $widget->get_event_listeners()) {
			if ($listener->can_handle($event)) {
				return $listener->send_event($event, $widget);
			}
		}
		$dont_dispatch_further and return;
		if ($widget->isa('Curses::Toolkit::Widget::Window')) {
			$widget = $widget->get_root_window();
		} elsif ($widget->isa('Curses::Toolkit::Widget')) {
			$widget = $widget->get_parent();
		} else {
			return;
		}
		defined $widget or return;
	}
	return;
}


sub add_delay {
	my $self = shift;
	my $mainloop = $self->get_mainloop();
	defined $mainloop or return;
	$mainloop->add_delay(@_);
	return;
}

# ## Private methods ##

# # event_handling

# my @supported_events = (qw(Curses::Toolkit::Event::Shape));
# sub _handle_event {
# 	my ($self, $event) = @_;
# 	use List::MoreUtils qw(any);
# 	if ( any { $event->isa($_) } @supported_events ) {
# 		my $method_name = '_event_' . lc( (split('::|_', ref($event)))[-1] ) . '_' .  $event->get_type();
# 		if ($self->can($method_name)) {
# 			return $self->$method_name();
# 		}
# 	}
# 	# event failed being applied
# 	return 0;
# }

# core event handling for Curses::Toolkit::Event::Shape event of type 'change'
sub _event_shape_change {
	my ($self) = @_;

	my ($screen_h, $screen_w);
	$self->_recompute_shape();

# for now we rebuild all coordinates
 	foreach my $window ( $self->get_windows() ) {
		$window->rebuild_all_coordinates();
 	}

# for now rebuild everything
#	my $mainloop = $self->get_mainloop();
#	if (defined $mainloop) {
#		$mainloop->needs_redraw();
#	}

	# event suceeded
	return 1;

}

sub _recompute_shape {
	my ($self) = @_;
	use Curses::Toolkit::Object::Coordinates;
	my ($screen_h, $screen_w);
    use Curses;
	endwin;
	$self->{curses_handler}->getmaxyx($screen_h, $screen_w);
	use Curses::Toolkit::Object::Shape;
	$self->{shape} ||= Curses::Toolkit::Object::Shape->new_zero();
	$self->{shape}->_set(
		x2 => $screen_w,
		y2 => $screen_h,
	);
	return $self;
}

sub _rebuild_all {
	my ($self) = @_;
	foreach my $window ($self->get_windows()) {
		$window->rebuild_all_coordinates();
	}
	return $self;
}

1;


__END__

=pod

=head1 NAME

Curses::Toolkit - a modern Curses toolkit

=head1 VERSION

version 0.093000

=head1 SYNOPSIS

  # spawn a root window
  my $root_window = POE::Component::Curses->spawn();
  # adds some widget
  $root->add_window(
      my $window = Curses::Toolkit::Widget::Window
        ->new()
        ->set_name('main_window')
        ->add_widget(
          my $button = Curses::Toolkit::Widget::Button
            ->new_with_label('Click Me to quit')
            ->set_name('my_button')
            ->signal_connect(clicked => sub { exit(0); })
        )
        ->set_coordinates(x1 => 0,   y1 => 0,
                          x2 => '100%',
                          y2 => '100%',
                         )
  );

  # start main loop
  POE::Kernel->run();

=head1 DESCRIPTION

This module tries to be a modern curses toolkit, based on the Curses module, to
build "semi-graphical" user interfaces easily.

B<WARNING> : This is still in "beta" version, not all the features are
implemented, and the API may change. However, most of the components are there,
and things should not change that much in the future... Still, don't use it in
production, and don't consider it stable.

L<Curses::Toolkit> is meant to be used with a mainloop, which is not part of this
module. I recommend you L<POE::Component::Curses>, which is probably what you
want. L<POE::Component::Curses> uses Curses::Toolkit, but provides a mainloop
and handles keyboard, mouse, timer and other events, whereas Curses::Toolkit is
just the drawing library. See the example above. the C<spawn> method returns a
L<Curses::Toolkit> object, which you can call methods on.

If you already have a mainloop or if you don't need it, you might want
to use Curses::Toolkit directly. But again, it's probably not what you want to
use. In this case you would do something like :

  use Curses::Toolkit;

  # using Curses::Toolkit without any event loop
  my $root = Curses::Toolkit->init_root_window();
  my $window = Curses::Toolkit::Widget::Window->new();
  $root->add($window);
  ...
  $root->render

=head1 WIDGETS

Curses::Toolkit is based on a widget model, inspired by Gtk. I suggest you read the pod of the following widgets :

=over 

=item L<Curses::Toolkit::Widget::Window>

Use this widget to create a window. It's the first thing to do once you have a root_window

=item L<Curses::Toolkit::Widget>

Useful to read, it contains the common methods of all the widgets

=item L<Curses::Toolkit::Widget::Label>

To display simple text

=item L<Curses::Toolkit::Widget::Button>

Simple interaction with the user

=item L<Curses::Toolkit::Widget::Entry>

To input text from the user

=item L<Curses::Toolkit::Widget::VBox>

To pack widgets vertically, thus building complex layouts

=item L<Curses::Toolkit::Widget::HBox>

To pack widgets horizontally, thus building complex layouts

=item L<Curses::Toolkit::Widget::Border>

Add a simple border around any widget

=item L<Curses::Toolkit::Widget::HPaned>

To pack 2 widgets horizontally with a flexible gutter

=item L<Curses::Toolkit::Widget::VPaned>

To pack 2 widgets vertically with a flexible gutter

=item L<Curses::Toolkit::Widget::HScrollBar>

Not yet implemented

=item L<Curses::Toolkit::Widget::VScrollBar.pm>

Not yet implemented

=back 

=head1 CLASS METHODS

=head2 init_root_window

  my $root = Curses::Toolkit->init_root_window();

Initialize the Curses environment, and return an object representing it. This
is not really a constructor, because you can't have more than one
Curses::Toolkit object for one Curses environment. Think of it more like a
service.

  input  : clear_background  : optional, boolean, default 1 : if true, clears background
           theme_name        : optional, the name of them to use as default diosplay theme
           mainloop          : optional, the mainloop object that will be used for event handling
  output : a Curses::Toolkit object



=head1 METHODS

=head2 get_theme_name

  my $theme_name = $root_window->get_theme_name();

Return the theme associated with the root window. Typically used to get a
usable default theme name. Use tha instead of hard-wiring
'Curses::Toolkit::Theme::Default'



=head2 add_event_listener

  $root->add_event_listener($event_listener);

Adds an event listener to the root window. That allows the root window to
respond to some events

  input : a Curses::Toolkit::EventListener
  output : the root window



=head2 get_event_listeners

  my @listeners = $root->get_event_listener();

Returns the list of listeners connected to the root window.

  input : none
  output : an ARRAY of Curses::Toolkit::EventListener



=head2 get_focused_widget

  my $widget = $root->get_focused_widget();

Returns the widget currently focused. Warning, the returned widget could well
be a window.

  input : none
  output : a Curses::Toolkit::Widget or void



=head2 get_focused_window

  my $window = $root->get_focused_window();

Returns the window currently focused.

  input : none
  output : a Curses::Toolkit::Widget::Window or void



=head2 set_mainloop

  $root->set_mainloop($mainloop)

Sets the mainloop object to be used by the Curses::Toolkit root object. The
mainloop object will be called when a new event has to be registered. The
mainloop object is in charge to listen to the events and call $root->dispatch_event()

  input  : a mainloop object
  output : the Curses::Toolkit object



=head2 get_mainloop

  my $mainloop = $root->get_mainloop()

Return the mainloop object associated to the root object. Might be undef if no
mainloop were associated.

  input : none
  output : the mainloop object, or undef



=head2 get_shape

  my $coordinate = $root->get_shape();

Returns a coordinate object that represents the size of the root window.

  input  : none
  output : a Curses::Toolkit::Object::Coordinates object



=head2 add_window

  my $window = Curses::Toolkit::Widget::Window->new();
  $root->add_window($window);

Adds a window on the root window. Returns the root window

  input : a Curses::Toolkit::Widget::Window object
  output : the root window



=head2 needs_redraw

  $root->needs_redraw()

When called, signify to the root window that a redraw is needed. Has an effect
only if a mainloop is active ( see POE::Component::Curses )

  input : none
  output : the root window



=head2 get_windows

  my @windows = $root->get_windows();

Returns the list of windows loaded

  input : none
  output : ARRAY of Curses::Toolkit::Widget::Window



=head2 set_modal_widget

Set a widget to be modal

  input  : a widget
  output : the root window



=head2 unset_modal_widget

Unset the widget to be modal

  input  : none
  output : the root window



=head2 get_modal_widget

returns the modal widget, or void

  input  : none
  output : the modal widget or void



=head2 show_all

  $root->show_all();

Set visibility property to true for every element. Returns the root windows

  input : none
  output : the root window



=head2 render

  $root->render();

Build everything in the buffer. You need to call 'display' after that to display it

  input : none
  output : the root window



=head2 display

  $root->display();

Refresh the screen.

  input  : none
  output : the root window



=head2 dispatch_event

  my $event = Curses::Toolkit::Event::SomeEvent->new(...)
  $root->dispatch_event($event);

Given an event, dispatch it to the appropriate widgets / windows, or to the root window.

  input  : a Curses::Toolkit::Event
  output : true if the event were handled, false if not



=head2 add_delay

Has an effect only if a mainloop is active ( see POE::Component::Curses )

  $root_window->add_delay($seconds, \&code, @args)
  $root_window->add_delay(5, sub { print "wow, 5 seconds wasted, dear $_[0]\n"; }, $name);

Add a timer that will execute the \&code once, in $seconds seconds. $seconds
can be a fraction. @args will be passed to the code reference

  input  : number of seconds
           a code reference
           an optional list of arguments to be passed to the code reference
  output : a timer unique identifier or void



=head1 BUGS

Please report any bugs or feature requests to
C<bug-curses-toolkit at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Curses-Toolkit>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Curses::Toolkit

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Curses-Toolkit>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Curses-Toolkit>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Curses-Toolkit>

=item * Search CPAN

L<http://search.cpan.org/dist/Curses-Toolkit>

=back 

=head1 AUTHOR

  Damien "dams" Krotkine

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Damien "dams" Krotkine.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 