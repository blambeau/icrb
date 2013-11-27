#
# Information Contracts for Ruby
#
module ICRb

  # Marker for unset arguments
  Unset = Object.new
  def Unset.to_s
    "default"
  end

  # The predicate that accepts all values
  All = ->(arg){ true }

  # Default contract options
  DefaultOptions = {
    accessors: true
  }

end # module ICRb
require "icrb/version"
require "icrb/loader"
require "icrb/errors"

require "icrb/adt"
require "icrb/contract"
require "icrb/choice"

require "icrb/ext/alf"
