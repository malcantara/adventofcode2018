defmodule Day1 do
  def final_frequency(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule Day1Test do
      use ExUnit.Case

      import Day1

      test "final_frequency" do
        assert final_frequency("""
               +1
               +1
               +1
               """) === 3

        assert final_frequency("""
               +1
               +1
               -2
               """) === 0

        assert final_frequency("""
               -1
               -2
               -3
               """) === -6
      end
    end

  [input_file] ->
    input_file
    |> File.read!()
    |> Day1.final_frequency()
    |> IO.puts()

  _ ->
    IO.puts(:stderr, "we expected --test or an input file")
    System.halt(1)
end
