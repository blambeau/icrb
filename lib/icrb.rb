#
# Information Contracts for Ruby
#
module ICRb

  Unset = Object.new
  def Unset.to_s
    "default"
  end

  TruePredicate = ->(arg){ true }

end # module ICRb
require "icrb/version"
require "icrb/loader"
require "icrb/errors"

require "icrb/adt"
require "icrb/choice"
require "icrb/base"

require "icrb/ext/alf"
