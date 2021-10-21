# frozen_string_literal: true

# Helper assertions for writing easy-to-understand tests
module Assertions
  # Checks whether a change occurs in the value returned by a callable
  def assert_change(callable, from: :__not_given__, to: :__not_given__)
    raise ArgumentError, "`assert_change' requires a block" unless block_given?

    before = callable.call
    check_before(before, from)

    yield

    after = callable.call
    check_after(after, to)

    check_for_change(from, to)
  end

  private

  def check_before(before, from)
    return if from == :__not_given__

    assert_equal(
      before,
      from,
      "expected to start at #{from.inspect}, but started at #{before.inspect}"
    )
  end

  def check_after(after, to)
    return if to == :__not_given__

    assert_equal(
      after,
      to,
      "expected to change to #{to.inspect}, but was #{after.inspect}"
    )
  end

  def check_for_change(from, to)
    return unless from == to && from == :__not_given__

    refute_equal(
      before,
      after,
      "expected to change, but remained #{from.inspect}"
    )
  end
end
