defmodule FizzBuzz do
  defp fizz(n) do
    if rem(n, 3) == 0 do
      IO.write "Fizz"
      true
    else
      false
    end
  end

  defp buzz(n) do
    if rem(n, 5) == 0 do
      IO.write "Buzz"
      true
    else
      false
    end
  end

  def fizzbuzz(first, last) when first > last do
    :ok
  end

  def fizzbuzz(first, last) when first <= last do
    is_fizz = fizz(first)
    is_buzz = buzz(first)
    if not (is_fizz or is_buzz) do
      IO.write first
    end
    IO.write "\n"
    fizzbuzz(first + 1, last)
  end

  def fizzbuzz() do
    fizzbuzz(1, 100)
  end
end

FizzBuzz.fizzbuzz()
