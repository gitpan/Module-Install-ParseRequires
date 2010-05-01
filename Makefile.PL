use inc::Module::Install;

name 'Module-Install-ParseRequires';
all_from 'lib/Module/Install/ParseRequires.pm';
readme_from 'lib/Module/Install/ParseRequires.pm';

resources repository => 'http://github.com/robertkrimen/Module-Install-ParseRequires';

parse_requires <<_END_;
Module::Install 0.85
_END_

parse_requires test => <<_END_;
Test::More
YAML::Tiny
File::Spec
_END_

auto_install;

WriteAll;
