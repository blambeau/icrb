$:.unshift('../lib')
$:.unshift('../../../lib')

require 'bundler/setup'
require 'chess'
require 'path'

def count(*args, &bl)
  Alf::Aggregator.count(*args, &bl)
end
