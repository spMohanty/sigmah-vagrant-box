class sigmah::maven_proxy_setup inherits sigmah {

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
	      mode => 0775,
	      owner => 'vagrant',
	      group => 'vagrant',
	      content => template("sigmah/maven_proxy.erb"),
	    } 

}