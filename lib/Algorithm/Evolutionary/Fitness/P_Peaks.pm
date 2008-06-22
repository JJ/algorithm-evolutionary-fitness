use strict; # -*- cperl -*-
use warnings;

=head1 NAME

    Algorithm::Evolutionary::Fitness::P_Peaks - P Peaks problem generator

=head1 SYNOPSIS

    my $number_of_peaks = 100;
    my $number_of_bits = 32;
    my $p_peaks = Algorithm::Evolutionary::Fitness::P_Peaks->new( $number_of_peaks, $number_of_bits );

=head1 DESCRIPTION

P_Peaks fitness function; optimizes the distance to the closest in a series of peaks

=head1 METHODS

=cut

package Algorithm::Evolutionary::Fitness::P_Peaks;

our $VERSION = ( '$Revision: 1.8 $ ' =~ /(\d+\.\d+)/ ) ;

use String::Random;

use lib qw(../../.. ../.. ..);

use base qw(Algorithm::Evolutionary::Fitness::Base);
use Algorithm::Evolutionary::Utils qw(hamming);

=head2 new

    Creates a new instance of the problem, with the said number of bits and peaks

=cut 

sub new {
  my $class = shift;
  my ($peaks, $bits ) = @_;

  #Generate peaks
  my $generator = new String::Random;
  my @peaks;
  my $regex = "\[01\]{$bits}";
  my $self = { bits => $bits,
	       generator => $generator,
	       regex => $regex };
  for my $p ( 1..$peaks ) {
    push( @peaks, $generator->randregex($regex));
  }
  $self->{'peaks'} = \@peaks;
  bless $self, $class;
  $self->initialize();
  return $self;
}

=head2 random_string

Returns random string in the same style than the peaks. Useful for testing

=cut

sub random_string {
    my $self = shift;
    return $self->{'generator'}->randregex($self->{'regex'});
}

=head2 _apply

Applies the instantiated problem to a chromosome

=cut

sub _apply {
    my $self = shift;
    my $individual = shift;
    return $self->p_peaks( $individual->{_str})/$self->{'bits'} ;
}

=head2 p_peaks

Applies the instantiated problem to a string

=cut

our %cache;

sub p_peaks {
    my $self = shift;
    my @peaks = @{$self->{'peaks'}};
    my $string = shift;
    if ( $cache{$string} ) {
	return $cache{$string};
    }
    my $bits = $self->{'bits'};
    my @distances = sort {$b <=> $a}  map($bits - hamming( $string, $_), @peaks);
    $cache{$string} = $distances[0];
    return $cache{$string};

}

=head2 cached_evals

Returns the number of keys in the evaluation cache

=cut

sub cached_evals {
    return scalar keys %cache;
}

=head1 Copyright
  
  This file is released under the GPL. See the LICENSE file included in this distribution,
  or go to http://www.fsf.org/licenses/gpl.txt

  CVS Info: $Date: 2008/06/22 07:51:21 $ 
  $Header: /media/Backup/Repos/opeal/opeal/Algorithm-Evolutionary/lib/Algorithm/Evolutionary/Fitness/P_Peaks.pm,v 1.8 2008/06/22 07:51:21 jmerelo Exp $ 
  $Author: jmerelo $ 
  $Revision: 1.8 $
  $Name $

=cut

"What???";
