(defmodule mnemosyne-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest my-adder
  (is-equal 4 (mnemosyne:my-adder 2 2)))
