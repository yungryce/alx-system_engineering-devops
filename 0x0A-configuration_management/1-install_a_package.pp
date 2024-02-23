# Puppet manifest to install Flask and werkzeug package with pip3

# Ensure the flask specific version package is installed
package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}

# Ensure the specific version of Werkzeug is installed
package { 'Werkzeug':
  ensure   => '2.1.1',
  provider => 'pip3',
}
