defmodule StarFinder do
  def find_pairs(numbers, target, groups) do
    numbers
    |> Enum.find_value(fn n ->
      rem = target - n
      group = Integer.floor_div(rem, 100)

      with {:ok, list} <- Map.fetch(groups, group),
           true <- Enum.member?(list, rem) do
        {n, rem}
      else
        _ -> nil
      end
    end)
  end
end

numbers =
  "input.txt"
  |> File.read!()
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)

groups =
  numbers
  |> Enum.group_by(&Integer.floor_div(&1, 100))

{x, y} = StarFinder.find_pairs(numbers, 2020, groups)

IO.puts("The Answer is for part 1 is:")
IO.puts("#{x * y}")
IO.puts("x: #{x} y: #{y} -- #{x + y}")

{x, y, z} =
  numbers
  |> Enum.find_value(fn n ->
    rem = 2020 - n

    with {y, z} <- StarFinder.find_pairs(numbers, rem, groups) do
      {n, y, z}
    else
      _ -> nil
    end
  end)

IO.puts("The Answer is for part 2 is:")
IO.puts("#{x * y * z}")
IO.puts("x: #{x} y: #{y} z: #{z} -- #{x + y + z}")
