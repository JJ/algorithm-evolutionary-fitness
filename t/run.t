#!/usr/bin/perl

use strict;
use warnings;

#########################
use lib qw( . ../.. ../../.. .. ); #Just in case we are testing it in-place
use Algorithm::Evolutionary::Experiment;
use Algorithm::Evolutionary::Op::Easy;

use Test;
BEGIN { plan tests => 4 };
#########################


my @files = qw( marea.xml royalroad.xml onemax.xml experiment.xml );

for ( @files ) {	
  local( $/, *X);
  open (X, "<xml/$_" ) || die "Problems opening xml/$_: $@\n";
  my $xml = <X>;
  close X;
  my $xp = Algorithm::Evolutionary::Experiment->fromXML( $xml );
  my $popRef = $xp->go();	
  ok ( $popRef->[0]->Fitness() > 0, 1 );
}


########################################################################

=head1 Copyright
  
  This file is released under the GPL. See the LICENSE file included in this distribution,
  or go to http://www.fsf.org/licenses/gpl.txt

  CVS Info: $Date: 2008/02/12 17:49:38 $ 
  $Header: /media/Backup/Repos/opeal/opeal/Algorithm-Evolutionary/t/run.t,v 1.1 2008/02/12 17:49:38 jmerelo Exp $ 
  $Author: jmerelo $ 
  $Revision: 1.1 $
  $Name $

=cut
