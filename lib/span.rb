require 'span/date_diff'
require 'span/version'

module Span
  def self.compute( *args , &block )
    DateDiff.compute *args , &block
  end
end
