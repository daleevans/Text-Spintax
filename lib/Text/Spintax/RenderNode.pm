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
