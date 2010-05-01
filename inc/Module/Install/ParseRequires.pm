#line 1
package Module::Install::ParseRequires;

use strict;
use warnings;

use base qw/ Module::Install::Base /;

our $VERSION = 0.001;

require ExtUtils::MakeMaker;
   
sub _parse_requires_method ($) {
    local $_ = shift;
    return 'requires' unless defined;
    if ( ! s/=//g ) {
        s/_*$//;
        $_ .= '_requires' unless m/_?(?:requires|recommends)$/;
    }
    return $_;
}

sub parse_requires {
    my $self = shift;
    my ( $requires, $method );
    if ( @_ > 1 ) {
        $method = _parse_requires_method shift;
    }
    else {
        $method = 'requires';
    }
    $requires = shift;

    for my $line ( split m/\n/, $requires ) {
        s/^\s*//, s/\s*$// for $line;
        if ( $line =~ m/^([\w\=]+):$/ ) {
            $method = _parse_requires_method $1;
        }
        else {
            my ( $dist, $version ) = split m/\s+/, $line, 2;
            $version ||= 0;
            $self->$method( $dist => $version );
        }
    }
}

sub parse_recommends {
    my $self = shift;
    $self->parse_requires( recommends => @_ );
}

1;
__END__

#line 129
