# frozen_string_literal: true

module Arel # :nodoc: all
  module Nodes
    class Matching < Binary
      include FetchAttribute

      attr_reader :escape
      attr_accessor :case_sensitive

      def initialize(left, right, escape = nil, case_sensitive = false)
        super(left, right)
        @escape = escape && Nodes.build_quoted(escape)
        @case_sensitive = case_sensitive
      end
    end

    class Matches < Matching
      def invert
        Arel::Nodes::DoesNotMatch.new(left, right, escape, case_sensitive)
      end
    end

    class DoesNotMatch < Matching
      def invert
        Arel::Nodes::Matches.new(left, right, escape, case_sensitive)
      end
    end
  end
end
