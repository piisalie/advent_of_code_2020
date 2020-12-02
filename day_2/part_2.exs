File.read!("input.txt")
|> String.split("\n", trim: true)
|> Enum.filter(fn line ->
  [range, letter, password] = line |> String.split(" ", trim: true)
  letter = letter |> String.replace(":", "")
  [lower, upper] = range |> String.split("-") |> Enum.map(&String.to_integer/1)

  x = String.at(password, lower - 1)
  y = String.at(password, upper - 1)

  case [x == letter, y == letter] do
    [true, false] -> true
    [false, true] -> true
    _ -> false
  end
end)
|> length
|> IO.inspect(label: "total count")
