require 'benchmark'
require 'sax-machine'
require 'cgi'

require './lib/feedzirra/core_ext'
require './lib/feedzirra/feed_utilities'
require './lib/feedzirra/feed_entry_utilities'
require './lib/feedzirra/parser/atom_entry'
require './lib/feedzirra/parser/atom'

xhtml_atom_content = File.read './spec/sample_feeds/pet_atom.xml'
iterations = 100

Benchmark.bmbm do |b|
  # just to be explicit
  Feedzirra::Parser::Atom.preprocess_xml = false

  b.report 'basic parse' do
    iterations.times do
      Feedzirra::Parser::Atom.parse(xhtml_atom_content)
    end
  end

  # and now let's preprocess
  Feedzirra::Parser::Atom.preprocess_xml = true

  b.report 'preprocessed' do
    iterations.times do
      Feedzirra::Parser::Atom.parse(xhtml_atom_content)
    end
  end
end
