requires 'CHI';
requires 'DateTime';
requires 'DateTime::Format::RSS';

on build => sub {
    requires 'ExtUtils::MakeMaker', '6.59';
    requires 'Module::Install';
    requires 'Test::Exception';
    requires 'Test::More';
};
