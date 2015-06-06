package DateTime::Format::Startsiden;

use Carp;
use CHI;

use DateTime::Format::RSS;
use DateTime::TimeZone;

use strict;
use vars qw($VERSION);
$VERSION = '1.02';

my $cache = CHI->new( driver => 'Memory', global => 1, max_size => 1024 * 1024 );
my $fmt = DateTime::Format::RSS->new;

sub parse_datetime {
    my ($class, $string, $opts) = @_;
    $opts //= {};

    my $dt = eval {
        local $SIG{__DIE__};
        $cache->get($string);
    };

    return $dt if $dt;

    eval {
        local $SIG{__DIE__};
        $dt = $fmt->parse_datetime($string) or die("Invalid date format: '$string'\n");
        $cache->set($string, $dt);
    };

    return (defined $dt) ? $dt : _error($@, $opts);
}

sub parse_url {
    my ($class, $url, $opts) = @_;

    my $dt = eval {
        local $SIG{__DIE__};
        $cache->get($url);
    };
    return $dt if $dt;

    my ($year, $month, $day) = ($url =~ m{ /? (\d{4}) (?: /? (\d{1,2}) )? (?: /? (\d{1,2}) )?}gmx);
    eval {
        local $SIG{__DIE__};
        if ($year) {
           $dt = DateTime->new(
              ( $year  ? ( year  => $year  ) : () ),
              ( $month ? ( month => $month ) : () ),
              ( $day   ? ( day   => $day   ) : () ),
           );
           $cache->set($url, $dt);
        }
    };
    return (defined $dt) ? $dt : _error("Invalid date format: '$url'\n", $opts);;
}

sub _error {
    my ($msg, $opts) = @_;
    chomp $msg;
    if (defined $opts->{callback} && ref $opts->{callback} eq 'CODE') {
        return $opts->{callback}->($msg) || Carp::carp("$msg, using DateTime->now()") && DateTime->now();
    } else {
        $opts->{fatal} ? Carp::croak($msg) : Carp::carp("$msg, using DateTime->now()");
    }
    return DateTime->now();
}

1;

__END__

=pod
 
=head1 NAME
 
DateTime::Format::Startsiden - Parse and format various datetime strings
 
=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use DateTime::Format::Startsiden;

    my $dt = DateTime::Format::Startsiden->parse_datetime('2014-04-01T12:34:56+00:00');
    my $dt = DateTime::Format::Startsiden->parse_datetime('2014-04-01T12:34:56+0000');
    my $dt = DateTime::Format::Startsiden->parse_datetime('20140401T123456+0100');
    my $dt = DateTime::Format::Startsiden->parse_datetime('abc', { fatal => 1 } );
    my $dt = DateTime::Format::Startsiden->parse_datetime('abc', { callback => sub { warn "Error: @_"; return DateTime->now() } } );

    my $dt = DateTime::Format::Startsiden->parse_url('/2014/04/01/some-article');
    my $dt = DateTime::Format::Startsiden->parse_url('/2014/04/some-articles');
    my $dt = DateTime::Format::Startsiden->parse_url('/2014/some-articles');
    my $dt = DateTime::Format::Startsiden->parse_url('abc', { fatal => 1 } );
    my $dt = DateTime::Format::Startsiden->parse_url('abc', { callback => sub { warn "Error: @_"; return DateTime->now() } } );

See tests for more inputs and expected outputs

=head1 DESCRIPTION

This module tries to understand as many date formats as possible by using L<DateTime::Format::RSS>
which in turn uses various DateTime::Format modules to parse whatever it gets. If it fails, it fallbacks to using DateTime->now().

You can override the fallback, by using the callback parameter and return either nothing to get DateTime->now() or whatever is suitable for your project.

=head1 METHODS
 
=over
 
=item C<parse_datetime($string, $opts)>

The C<parse_datetime> method tries to parse the string and returns a DateTime object. 

If failing to parse the string as a date it defaults to return C<DateTime->new()>

Options:

 * fatal    - if set, croaks if failing to understand date format
 * callback - a sub ref that is called if failing to understand date format, parameter is the error message, if it returns a true value, that will be returned to the caller

=item C<parse_url($url, $opts)>

The C<parse_url> method only tries to find [YYYY[MM[DD]]] or [/YYYY[/MM[/DD]]] or any mixtures of those two and returns a L<DateTime> object.

If failing to parse the string as a date it defaults to return C<DateTime->new()>

Options:
 * Same as C<parse_datetime()>

=item C<format_datetime($datetime, $opts)>
 
TODO: Not implemented
 
For simplicity, the datetime will be converted to UTC first.
 
=back
 
=head1 SEE ALSO
 
=over 4
 
=item * L<DateTime>
 
=item * L<DateTime::Format::RSS>

=item * L<DateTime::Format::RFC3339>
 
=item * L<DateTime::Format::ISO8601>

=item * L<DateTime::Format::Parse>
 
=item * L<http://tools.ietf.org/html/rfc3339>, "Date and Time on the Internet: Timestamps"
 
=item * L<http://tools.ietf.org/html/rfc4287>, "The Atom Syndication Format"
 
=back
 
 
=head1 BUGS
 
Please report any bugs or feature requests to http://bugs.startsiden.no/,
 
=head1 SUPPORT
 
You can find documentation for this module with the perldoc command.
 
    perldoc DateTime::Format::Startsiden
 
=head1 AUTHOR
 
Nicolas Mendoza, C<< <nicolas.mendoza@startsiden.no> >>
 
=head1 COPYRIGHT & LICENSE

All Rights reserved to ABC Startsiden © 2014
