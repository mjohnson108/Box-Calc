package Box::Calc::BoxType;

use strict;
use warnings;
use Moose;
with 'Box::Calc::Role::Container';
with 'Box::Calc::Role::Mailable';
use Ouch;

=head1 NAME

Box::Calc::BoxType - The container class for the types (sizes) of boxes that can be used for packing.

=head1 SYNOPSIS

 my $item = Box::Calc::BoxType->new(name => 'Apple', x => 3, y => 3.3, z => 4, weight => 5 );

=head1 METHODS

=head2 new(params)

Constructor.

=over

=item params

=over

=item x

The interior width of your box.

=item y

The interior length of your box.

=item z

The interior thickness of your box.

=item name

The name of your box.

=item weight

The weight of your box.

=back

=back

=head2 name

Returns the name of this box.


=head2 category

Returns the category name associated with this box type if any.

=cut


has name => (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
);

has category => (
    is          => 'ro',
    isa         => 'Str',
    default     => '',
);

=head2 describe

Returns a hash ref with the properties of this box type.

=cut

sub describe {
    my $self = shift;
    return {
        name    => $self->name,
        weight  => $self->weight,
        x       => $self->x,
        y       => $self->y,
        z       => $self->z,
        category=> $self->category,
    };
}


no Moose;
__PACKAGE__->meta->make_immutable;
