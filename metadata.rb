name 'hem'
maintainer 'Inviqa UK Ltd'
maintainer_email 'kevans@inviqa.com'
license 'apache2'
description 'Installs/Configures hem'
long_description 'Installs/Configures hem'
version '0.1.1'

depends 'apt'
depends 'git'
depends 'vagrant', '~> 0.3.0'
depends 'yum'

supports 'centos', '>= 6.7'
supports 'redhat', '>= 6.7'
supports 'ubuntu', '>= 14.04'

recipe 'hem::default', 'Install hem'
recipe 'hem::environment', 'Set up the environment variables required for using hem\'s built in ruby'
