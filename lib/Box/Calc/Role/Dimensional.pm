package Box::Calc::Role::Dimensional;

use strict;
use warnings;
use Moose::Role;

=head1 NAME

Box::Calc::Role::Dimensional - Role to add standard dimensions to objects.


=head2 SYNOPSIS

The x, y, and z attributes are first sorted from largest to smallest before creating the object. So you can insert them in any order. x=3, y=9, z=1 would become x=r9, y=3, z=1.

   #----------#
   |          |
   |          |
   | Y        |
   |          |
   |          |
   |     X    |
   #----------#

 Z is from bottom up


=head1 METHODS

This role installs these methods:

=head2 x

Returns the largest side of an object.

=cut

has x => (
    is          => 'rw',
    required    => 1,
    isa         => 'Num',
);

=head2 y

Returns the middle side of an object.

=cut

has y => (
    is          => 'rw',
    required    => 1,
    isa         => 'Num',
);

=head2 z

Returns the shortest side of an object.

=cut

has z => (
    is          => 'rw',
    required    => 1,
    isa         => 'Num',
);

=head2 weight

Returns the weight of an object.

=cut

has weight => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

=head2 volume

Returns the result of multiplying x, y, and z.

=cut

sub volume {
    my ($self) = @_;
    return $self->x * $self->y * $self->z;
}

=head2 dimensions

Returns an array reference containing x, y, and z.

=cut

sub dimensions {
    my ($self) = @_;
    return [ $self->x, $self->y, $self->z, ];
}

=head2 extent

Returns a string of C<x,y,z>. Good for comparing whether two items are dimensionally similar.

=cut

sub extent {
    my ($self) = @_;
    return join ',', $self->x, $self->y, $self->z; 
}

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

    # sort large to small
	my ( $x, $y, $z );
    
    if ( $args->{no_sort} ) {
        ( $x, $y, $z ) = ( $args->{x}, $args->{y}, $args->{z} );
    }
    elsif ( $args->{swap_xy} ) {
        ( $x, $y, $z ) = sort { $b <=> $a } ( $args->{x}, $args->{y}, $args->{z} );
        ( $x, $y ) = ( $y, $x );
    }
    else {
        ( $x, $y, $z ) = sort { $b <=> $a } ( $args->{x}, $args->{y}, $args->{z} );
    }

    $args->{x} = $x;
    $args->{y} = $y;
    $args->{z} = $z;
    return $className->$orig($args);
};

1;
