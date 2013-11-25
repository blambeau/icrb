module Alf
  module Algebra
    class Up
      include Shortcut
      include Unary

      signature do |s|
        s.argument :attributes, Heading, []
      end

      def heading
        @heading ||= operand.heading.merge(coercions)
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
          [name, ->(t){ ic.alpha(t[name]) }]
        }
        Hash[ext]
      end

    end # class Up
  end # module Algebra
end # module Alf
