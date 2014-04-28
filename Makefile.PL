use inc::Module::Install;

name 'DateTime-Format-Startsiden';

# These override things fetched by 'all_from' below.
# They must come *before* the call to 'all_from'.
perl_version '5.010001';
license 'proprietary'; # the license type ('all_from' needs this)

all_from 'lib/DateTime/Format/Startsiden.pm';

configure_requires 'Module::Install' => 0;

requires 'DateTime';
requires 'DateTime::Format::RSS';
test_requires 'Test::More';
test_requires 'Test::Exception';

tests_recursive;

WriteAll;
