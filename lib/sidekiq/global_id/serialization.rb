# frozen_string_literal: true

module Sidekiq
  module GlobalID
    # A refinement that defines how to [de]serialize Sidekiq arguments as GlobalIDs
    #
    # To make the logic easier to understand, this refinement houses all of the
    # specializations for both serialization and deserialization from GlobalIDs for
    # all types of arguments that you may find in Sidekiq arguments. This allows the
    # middleware to remain simple even as we add support for different types of
    # objects.
    #
    # @api private
    module Serialization
      refine Enumerable do
        def deserialize
          map!(&:deserialize)
        end

        def serialize
          map(&:serialize)
        end
      end

      refine Hash do
        def deserialize
          transform_keys!(&:deserialize)
          transform_values!(&:deserialize)
          self
        end

        def serialize
          transform_keys!(&:serialize)
          transform_values!(&:serialize)
          self
        end
      end

      refine Object do
        def deserialize
          self
        end

        def serialize
          return self unless respond_to?(:to_global_id)

          String(to_global_id)
        end
      end

      refine String do
        def deserialize
          return self unless start_with?("gid://")

          ::GlobalID::Locator.locate self
        end

        def serialize
          self
        end
      end
    end
  end
end
