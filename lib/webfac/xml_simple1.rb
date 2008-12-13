#!/usr/local/bin/ruby
require 'rubygems'
require 'xmlsimple'
require 'pp'

f=File.new('b.xml')
xmlstring = f.read

doc = XmlSimple.xml_in xmlstring
pp doc
