package Box::Calc::Role::Container;

use strict;
use warnings;
use Moose::Role;
with 'Box::Calc::Role::Dimensional';

=head1 NAME

Box::Calc::Role::Container - Extends the L<Box::Calc::Role::Dimensional> role to include outer dimensions.


=head1 METHODS

This role installs these methods:

=head2 outer_x

Returns the outside dimension of largest side of an object.

=cut

has outer_x => (
    is          => 'rw',
    isa         => 'Num',
    required    => 1,
);

=head2 outer_y

Returns the outside dimension of the middle side of an object.

=cut

has outer_y => (
    is          => 'rw',
    isa         => 'Num',
    required    => 1,
);

=head2 outer_z

Returns the outside dimension of the shortest side of an object.

=cut

has outer_z => (
    is          => 'rw',
    isa         => 'Num',
    required    => 1,
);

=head2 outer_volume

Returns the result of multiplying outer_x, outer_y, and outer_z.

=cut

has outer_volume => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

=head2 outer_dimensions

Returns an array reference containing outer_x, outer_y, and outer_z.

=cut

has outer_dimensions => (
    is          => 'ro',
    isa         => 'ArrayRef',
    required    => 1,
);

=head2 outer_extent

Returns a string of C<outer_x,outer_y,outer_z>. Good for comparing whether two items are dimensionally similar.

=cut

has outer_extent => (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
);

=head2 max_weight

The max weight of the items including the container. Defaults to 1000.

=cut

has max_weight => (
    is          => 'ro',
    isa         => 'Num',
    default     => 1000,
);

around BUILDARGS => sub {
    my $orig      = shift;
    my $className = shift;
    my $args;
    if (ref $_[0] eq 'HASH') {
        $args = shift;
    }
    else {
        $args = { @_ };
    }

    $args->{outer_x} ||= $args->{x};
    $args->{outer_y} ||= $args->{y};
    $args->{outer_z} ||= $args->{z};

    # sort large to small
	my ( $x, $y, $z ) = sort { $b <=> $a } ( $args->{outer_x}, $args->{outer_y}, $args->{outer_z} );
    
    $args->{outer_x} = $x;
    $args->{outer_y} = $y;
    $args->{outer_z} = $z;
    $args->{outer_volume} = $x * $y * $z;
    $args->{outer_dimensions} = [$x, $y, $z];
    $args->{outer_extent} = join(',', $x, $y, $z);
    return $className->$orig($args);
};

1;
