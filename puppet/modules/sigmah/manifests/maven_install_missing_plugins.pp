class sigmah::maven_install_missing_plugins inherits sigmah {

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

}