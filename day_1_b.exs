defmodule Day1 do
  def find_first_frequency_twice(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> find_first_twice([])
  end

  defp find_first_twice(input, init_acc) when is_list(init_acc) do
    start =
      case init_acc do
        [] -> 0
        [h | _tail] -> h
      end

    frecuencies =
      Enum.reduce(input, [start], fn x, acc ->
        [h | _] = acc
        new_h = h + x
        [new_h | acc]
      end)
      |> Enum.reverse()

    frecuencies =
      case init_acc do
        [] ->
          frecuencies

        _ ->
          [_ | frecuencies] = frecuencies
          frecuencies
      end

    init_acc =
      init_acc
      |> Enum.reverse()

    new_acc =
      Enum.reduce_while(frecuencies, init_acc, fn x, acc ->
        if(Enum.member?(acc, x)) do
          {:halt, x}
        else
          {:cont, [x | acc]}
        end
      end)

    find_first_twice(input, new_acc)
  end

  defp find_first_twice(_input, init_acc) do
    init_acc
  end
end

case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule Day1Test do
      use ExUnit.Case

      import Day1

      test "find_first_frequency_twice" do
        assert find_first_frequency_twice("""
               +1
               -1
               """) === 0

        assert find_first_frequency_twice("""
               +3
               +3
               +4
               -2
               -4
               """) === 10

        assert find_first_frequency_twice("""
               -6
               +3
               +8
               +5
               -6
               """) === 5

        assert find_first_frequency_twice("""
               +7
               +7
               -2
               -7
               -4
               """) === 14
      end
    end

  [input_file] ->
    input_file
    |> File.read!()
    |> Day1.find_first_frequency_twice()
    |> IO.puts()

  _ ->
    IO.puts(:stderr, "we expected --test or an input file")
    System.halt(1)
end
