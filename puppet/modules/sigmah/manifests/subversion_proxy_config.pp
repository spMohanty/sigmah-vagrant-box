class sigmah::subversion_proxy_config inherits sigmah {
		#Copy over the template settings with correct permissions
	    file {'subversion-proxy-settings':
	      path => ["/etc/subversion/servers"],
	      mode => 0644,
	      owner => 'root',
	      group => 'root',
	      content => template("sigmah/subversion_proxy.erb"),
	    } 
}