#!/usr/bin/perl 

use strict;
use warnings;

use Test::Exception;
use Test::More;

use_ok('DateTime::Format::Startsiden');

# parse_datetime
{
  my $dt = DateTime::Format::Startsiden->parse_datetime('2014-04-01T12:34:56+00:00'); 
  is($dt, '2014-04-01T12:34:56', '2014-04-01T12:34:56+00:00 => 2014-04-01T12:34:56');
};

{
  my $dt = DateTime::Format::Startsiden->parse_datetime('2014-04-01T12:34:56+0000'); 
  is($dt, '2014-04-01T12:34:56', '2014-04-01T12:34:56+0000 => 2014-04-01T12:34:56');
};

{
  my $dt = DateTime::Format::Startsiden->parse_datetime('20140401T123456+0100'); 
  is($dt, '2014-04-01T12:34:56', '20140401T123456+0100 => 2014-04-01T12:34:56');
};

{
   my $dt = DateTime::Format::Startsiden->parse_datetime('abc'); 
   ok(ref $dt eq 'DateTime', 'invalid date returns a datetime object by default');
};

{
  my $dt = DateTime::Format::Startsiden->parse_datetime('Tue, 17 Jun 2014 15:40:00 +0200'); 
  is($dt, '2014-06-17T15:40:00', 'Tue, 17 Jun 2014 15:40:00 +0200 => 2014-06-17T15:40:00');
};

{
  dies_ok
    {
       my $dt = DateTime::Format::Startsiden->parse_datetime('abc', { fatal => 1 } )
    } 'parse_datetime dies when passing fatal option';

};

{
   my $dt = DateTime::Format::Startsiden->parse_datetime('abc', { callback => sub { warn "Caught error: @_"; return DateTime->now(); } } ); 
   ok(ref $dt eq 'DateTime', 'Error caught returning a datetime object');
};

{
  my $dt = DateTime::Format::Startsiden->parse_datetime('abc', { callback => sub { warn "Caught error: @_"; return; } } ); 
  ok(ref $dt eq 'DateTime', 'Error caught returning false should give DateTime object');
};

# parse_url
{
  my $dt = DateTime::Format::Startsiden->parse_url('/2014/04/02/some-article'); 
  is($dt, '2014-04-02T00:00:00', '/2014/04/02/some-article => 2014-04-02T00:00:00');
};

{
  my $dt = DateTime::Format::Startsiden->parse_url('/2014/04/some-articles'); 
  is($dt, '2014-04-01T00:00:00', '/2014/04/some-article => 2014-04-01T00:00:00');
};

{
  my $dt = DateTime::Format::Startsiden->parse_url('/2014/some-articles'); 
  is($dt, '2014-01-01T00:00:00', '/2014/some-article => 2014-01-01T00:00:00');
};

{
   my $dt = DateTime::Format::Startsiden->parse_url('abc'); 
   ok(ref $dt eq 'DateTime', 'invalid date returns a datetime object by default');
};

{
   my $dt = DateTime::Format::Startsiden->parse_url(''); 
   ok(ref $dt eq 'DateTime', 'invalid date returns a datetime object by default');
};

{
   my $dt = DateTime::Format::Startsiden->parse_url(); 
   ok(ref $dt eq 'DateTime', 'invalid date returns a datetime object by default');
};

{
  dies_ok
    {
      my $dt = DateTime::Format::Startsiden->parse_url('abc', { fatal => 1 } ); 
    } 'parse_url dies when passing fatal option';
};

{
   my $dt = DateTime::Format::Startsiden->parse_url('abc', { callback => sub { warn "Caught error: @_"; return DateTime->now(); } } ); 
   ok(ref $dt eq 'DateTime', 'Error caught returning a datetime object');
};

{
  my $dt = DateTime::Format::Startsiden->parse_url('abc', { callback => sub { warn "Caught error: @_"; return; } } ); 
  ok(ref $dt eq 'DateTime', 'Error caught returning false should give DateTime object');
};

done_testing;
