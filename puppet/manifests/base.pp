#
# base.pp
# Build Sigmah Vagrant box configuration from modules
# 
# sigmah-vagrant-box
# https://github.com/spMohanty/sigmah-vagrant-box
#


# Install openJDK 1.6
# Note : Installing 1.6 instead of 1.7 or the latest because
# Sigmah is developed under JDK 1.6 and issues like
# the one discussed here : https://groups.google.com/forum/#!searchin/sigmah-dev/lucia/sigmah-dev/vqTWs6_TU-U/KFoYu6_I_DAJ
# come up in case of JDK 1.7
package {"openjdk-6-jdk":
 ensure => installed,
 name => $operatingsystem ? {
   Ubuntu => "openjdk-6-jdk",
   CentOS => "java-1.6.0-openjdk",
 }
}

# Postgresql general config
class { 'postgresql':
  version => '9.2',
  manage_package_repo => true,
  charset => 'UTF8',
  locale  => 'en_US.UTF-8'
}

# Postgresql server config
class { 'postgresql::server':
  config_hash => {
    'ip_mask_deny_postgres_user' => '0.0.0.0/32',
    'ip_mask_allow_all_users'    => '0.0.0.0/0',
    'listen_addresses'           => '*',
    'manage_redhat_firewall'     => true,
    'postgres_password'          => 'letmein',
  },
}

# Postgresql database config
# no op

# Install Maven to the vagrant users home dir and shell
maven::setup { "maven":
  ensure        => 'present',
  source        => 'apache-maven-3.1.1-bin.tar.gz',
  deploymentdir => '/home/vagrant/apache-maven',
  user          => 'vagrant',
  pathfile      => '/home/vagrant/.bashrc'
} ->

#ToDo : Temporary Solution !! Come up with a better solution for this.
##Copy filled up template from /vagrant/temp/settings.xml
    # First check the local configuration directory exists and has correct permissions
    exec { "ensure /home/vagrant/.m2":
      command => "/bin/mkdir -p /home/vagrant/.m2",
      creates => "/home/vagrant/.m2",
      user => "vagrant",
      group => "vagrant",
    } ->
    #Copy over the template settings with correct permissions
    file {'maven-proxy-settings':
      path => ["/home/vagrant/.m2/settings.xml"],
      ensure => present,
      mode => 0775,
      owner => 'vagrant',
      group => 'vagrant',
      source => "/vagrant/settings_templates/maven-settings.xml"
    } ->
    
  ##Install missing Maven plugins taken from https://code.google.com/p/sigma-h/downloads/detail?name=missing-jar-to-build-Sigmah.zip
  exec {"install_gwt-maps_1_1_1_jar" : 
    command => "/home/vagrant/apache-maven/bin/mvn install:install-file -Dfile=/vagrant/missing-jar-to-build-Sigmah/gwt-maps-1.1.1.its_a_jar -DgroupId=com.google.gwt.google-apis -DartifactId=gwt-maps -Dversion=1.1.1 -Dpackaging=jar",
    user => "vagrant",
    logoutput => "true"
  } ->
  exec {"install_gxt_2_2_5_gwt22_jar" : 
    command => "/home/vagrant/apache-maven/bin/mvn install:install-file -Dfile=/vagrant/missing-jar-to-build-Sigmah/gxt-2.2.5-gwt22.its_a_jar -DgroupId=com.extjs -DartifactId=gxt -Dversion=2.2.5-gwt22 -Dpackaging=jar",
    user => "vagrant",
    logoutput => "true"
  }

# Install Subversion client (only temporary...will soon be moving to github :D :D )
#
# To Do :: Add Proxy support for SVN conf based on the vagrant-proxy-conf settings
package {"subversion":
 ensure => "installed"
}





