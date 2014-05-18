defmodule Fib do
  @moduledoc """
  Several implementations of functions to compute values in the Fibonacci
  sequence.
  """

  def fib1(0) do
    0
  end
  def fib1(1) do
    1
  end
  @doc "Classic multiple dispatch implementation."
  def fib1(n) when n > 0 do
    fib1(n-1) + fib1(n-2)
  end

  @doc "Implementation using case."
  def fib2(n) do
    case n do
      0 ->
        0
      1 ->
        1
      _ when n > 0 ->
        fib2(n-1) + fib2(n-2)
    end
  end

end

IO.puts "Compute a few Fibonacci numbers..."
IO.puts "fib1(7): #{Fib.fib1 7}"
IO.puts "fib2(7): #{Fib.fib2 7}"
IO.puts "fib1(23): #{Fib.fib1 23}"
IO.puts "fib2(23): #{Fib.fib2 23}"
