lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'utracker'
require 'utracker/mongodb'

drawer = Utracker::MongoDB::Drawer.new
drawer.write_graph("examples/services.dot")
