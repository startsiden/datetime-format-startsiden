# NAME

DateTime::Format::Startsiden - Parse and format various datetime strings

# VERSION

Version 0.01

# SYNOPSIS

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

# DESCRIPTION

This module tries to understand as many date formats as possible by using [DateTime::Format::RSS](https://metacpan.org/pod/DateTime::Format::RSS)
which in turn uses various DateTime::Format modules to parse whatever it gets. If it fails, it fallbacks to using DateTime->now().

You can override the fallback, by using the callback parameter and return either nothing to get DateTime->now() or whatever is suitable for your project.

# METHODS

- `parse_datetime($string, $opts)`

    The `parse_datetime` method tries to parse the string and returns a DateTime object. 

    If failing to parse the string as a date it defaults to return `DateTime-`new()>

    Options:

        * fatal    - if set, croaks if failing to understand date format
        * callback - a sub ref that is called if failing to understand date format, parameter is the error message, if it returns a true value, that will be returned to the caller

- `parse_url($url, $opts)`

    The `parse_url` method only tries to find \[YYYY\[MM\[DD\]\]\] or \[/YYYY\[/MM\[/DD\]\]\] or any mixtures of those two and returns a [DateTime](https://metacpan.org/pod/DateTime) object.

    If failing to parse the string as a date it defaults to return `DateTime-`new()>

    Options:
     \* Same as `parse_datetime()`

- `format_datetime($datetime, $opts)`

    TODO: Not implemented

    For simplicity, the datetime will be converted to UTC first.

# SEE ALSO

- [DateTime](https://metacpan.org/pod/DateTime)
- [DateTime::Format::RSS](https://metacpan.org/pod/DateTime::Format::RSS)
- [DateTime::Format::RFC3339](https://metacpan.org/pod/DateTime::Format::RFC3339)
- [DateTime::Format::ISO8601](https://metacpan.org/pod/DateTime::Format::ISO8601)
- [DateTime::Format::Parse](https://metacpan.org/pod/DateTime::Format::Parse)
- [http://tools.ietf.org/html/rfc3339](http://tools.ietf.org/html/rfc3339), "Date and Time on the Internet: Timestamps"
- [http://tools.ietf.org/html/rfc4287](http://tools.ietf.org/html/rfc4287), "The Atom Syndication Format"

# BUGS

Please report any bugs or feature requests to http://bugs.startsiden.no/,

# SUPPORT

You can find documentation for this module with the perldoc command.

       perldoc DateTime::Format::Startsiden
    

# AUTHOR

Nicolas Mendoza, `<nicolas.mendoza@startsiden.no>`

# COPYRIGHT & LICENSE

All Rights reserved to ABC Startsiden © 2014
