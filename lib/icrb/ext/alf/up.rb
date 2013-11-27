module Alf
  module Algebra
    class Up
      include Shortcut
      include Unary

      signature do |s|
        s.argument :attributes, Heading, []
      end

      def heading
        @heading ||= operand.heading.merge(attributes)
      end

      def keys
        @keys ||= operand.keys
      end

      def expand
        extend(operand, extension)
      end

    private

      def extension
        ext = attributes.map{|name, ic|
          proc = ->(t){ ic.dress(t[name]) }
          [ name, TupleExpression.new(proc, nil, ic) ]
        }
        Hash[ext]
      end

    end # class Up
  end # module Algebra
end # module Alf
