#
# Information Contracts for Ruby
#
module ICRb

  # Marker for unset arguments
  Unset = Object.new
  def Unset.to_s
    "default"
  end

  # The true predicate for 'no contract restriction'
  TruePredicate = ->(arg){ true }

  # Default contract options
  DefaultOptions = {
    accessors: true
  }

end # module ICRb
require "icrb/version"
require "icrb/loader"
require "icrb/errors"

require "icrb/adt"
require "icrb/choice"
require "icrb/base"

require "icrb/ext/alf"
