requires 'CHI', '0.58';
requires 'DateTime';
requires 'DateTime::Format::RSS';
requires 'perl', '5.010001';

on build => sub {
    requires 'ExtUtils::MakeMaker', '6.59';
    requires 'Module::Install';
    requires 'Test::Exception';
    requires 'Test::More';
};
