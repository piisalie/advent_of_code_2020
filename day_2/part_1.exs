File.read!("input.txt")
|> String.split("\n", trim: true)
|> Enum.filter(fn line ->
  [range, letter, password] = line |> String.split(" ", trim: true)
  letter = letter |> String.replace(":", "")
  [lower, upper] = range |> String.split("-") |> Enum.map(&String.to_integer/1)

  count = password |> String.replace(~r/[^#{letter}]/, "") |> String.length

  count >= lower && count <= upper
end)
|> length
|> IO.inspect(label: "total count")
