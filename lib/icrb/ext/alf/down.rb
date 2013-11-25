module Alf
  module Algebra
    class Down
      include Shortcut
      include Unary

      class Omegaization

        def self.coerce(arg)
          case arg
          when Symbol then ArrayBased.new([arg])
          when Array  then ArrayBased.new(arg)
          when Hash   then HashBased.new(arg)
          else
            raise TypeError, "Unable to coerce `#{arg}` to Omegaization"
          end
        end

        class ArrayBased

          def initialize(list)
            @list = list
          end

          def to_heading(up_h)
            up_h.merge(rehash{|attr| up_h[attr].ics.datatype })
          end

          def to_extension
            rehash{|attr|
              ->(t){
                val = t[attr]
                val.class.omega(val)
              }
            }
          end

        private

          def rehash(&bl)
            Hash[@list.map{|attr| [attr, bl.call(attr) ] }]
          end

        end # class ArrayBased

        class HashBased

          def initialize(pairs)
            @pairs = pairs
          end

          def to_heading(up_h)
            up_h.merge(rehash{|attr, ic| up_h[attr].ics.datatype(ic) })
          end

          def to_extension
            rehash{|attr, ic|
              ->(t){
                val = t[attr]
                val.class.omega(val, ic)
              }
            }
          end

        private

          def rehash(&bl)
            Hash[@pairs.map{|attr,ic| [attr, bl.call(attr, ic) ] }]
          end

        end # class HashBased

      end # class Omegaization

      signature do |s|
        s.argument :attributes, Omegaization, []
      end

      def heading
        @heading ||= attributes.to_heading(operand.heading)
      end

      def keys
        @keys ||= operand.keys
      end

      def expand
        extend(operand, attributes.to_extension)
      end

    end # class Down
  end # module Algebra
end # module Alf
