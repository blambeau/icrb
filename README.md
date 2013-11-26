# ICRb

Information Contracts for Ruby.

## Links

* http://github.com/blambeau/icrb
* http://github.com/alf-tool/alf

## What is this?

An investigation of providing the dual of Axiomatic Contracts (read Abstract
Data Types) to software abstractions, to make data interoperability easier.

Information contract is about a way of getting the information content of an
abstraction, all the information and nothing but the information. Information
contracts work with bi-directional methods to dress an abstraction from pure
data (i.e. deserialization) and undress it easily (i.e. serialization).

All of this, without violating information hiding.

## Example

A very simple example below, that only involves a single class. The magic
would come when an entire system has information contracts. See the Chess
Board example in the `examples` folder for something more advanced.

```
class Color
  include ICRb::ADT

  # Internal representation
  def initialize(r, g, b)
    @r, @g, @b = r, g, b
  end
  attr_reader :r, :g, :b

  # Hexadecimal information contract, as needed for HTML/CSS interoperability
  ic :hex, String, /^#[0-9a-f]{6}/i do

    def alpha(s)
      Color.triple [1, 3, 5].map{|i| s[i, 2].to_i(16) }
    end

    def omega(color)
      "#" << color.to_triple.map{|i| i.to_s(16) }.join
    end

  end # ic :hex

  # Tuple information contract
  ic :rgb, Tuple[r: Integer, g: Integer, b: Integer] do

    def alpha(tuple)
      Color.new(tuple.r, tuple.g, tuple.b)
    end

    def omega(color)
      datatype.new(r: color.r, g: color.g, b: color.b)
    end

  end # ic Tuple[r, g, b]

  def to_s
    "Color(#{to_hex})"
  end

end # class Color

color = Color.rgb(r: 255, g: 192, b: 203)
puts color.to_hex
```