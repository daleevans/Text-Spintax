package Text::Spintax::RenderNode;

use Text::Spintax::Mo;

has 'parent' => (
   is => 'rw',
);

has 'children' => (
   is => 'rw',
);

has 'weight' => (
   is => 'rw',
);

has 'text' => (
   is => 'rw',
);

has 'type' => (
   is => 'rw',
);

=head1 SUBROUTINES/METHODS

=head2 render

   Generates a text string from all the possible variations.  Uses weights to determine how likely each possible string is to be rendered.

=cut

sub render {
   my $self = shift;
   if ($self->type eq "text") {
      return $self->text;
   }
   elsif ($self->type eq "spin") {
      my $total = 0;
      foreach my $child (@{$self->children}) {
         $total += $child->weight;
      }
      my $rand = rand $total;
      foreach my $child (@{$self->children}) {
         $rand -= $child->weight;
         $rand <= 0 and return $child->render;
      }
   }
   elsif ($self->type eq "sequence") {
      return join "", map { $_->render } @{$self->children};
   }
   else {
      die "invalid type";
   }
}

sub equal_path_weight {
   my $self = shift;
   $self->weight($self->num_paths);
   foreach my $child ($self->children ? @{$self->children} : ()) {
      $child->equal_path_weight;
   }
}

=head2 num_paths

   Returns the number of possible strings that could be generated from this node.  Combinatorially speaking, children of a sequence node multiply and children of a spin node add.

   "{a|b|c}" has 1+1+1=3 possibilities: a, b, c

   "{a|b} {c|d}" has 2*2=4 possibilities: a c, a d, b c, b d

=cut

sub num_paths {
   my $self = shift;
   if ($self->type eq "spin") {
      my $num_paths = 0;
      foreach my $child ($self->children ? @{$self->children} : ()) {
         $num_paths += $child->num_paths;
      }
      return $num_paths;
   }
   else {
      my $num_paths = 1;
      foreach my $child ($self->children ? @{$self->children} : ()) {
         $num_paths *= $child->num_paths;
      }
      return $num_paths;
   }
}

1;
