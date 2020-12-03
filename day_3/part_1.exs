defmodule Tobogganator do
  defstruct [:width, :map]

  def new(input) do
    result =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.graphemes/1)

    %__MODULE__{map: result, width: result |> hd |> length}
  end

  def at(%__MODULE__{width: width} = tob, x, y) when x >= width do
    offset = Integer.floor_div(x, tob.width)

    at(tob, x - width * offset, y)
  end

  def at(tob, x, y) do
    tob.map
    |> Enum.at(y, [])
    |> Enum.at(x)
  end

  def go(tob, x, y, slope, count) do
    case at(tob, x, y) do
      "#" -> go(tob, x + slope.x, y + slope.y, slope, count + 1)
      "." -> go(tob, x + slope.x, y + slope.y, slope, count)
      nil -> count
    end
  end
end

tob =
  "input.txt"
  |> File.read!()
  |> Tobogganator.new

slope = %{x: 3, y: 1}
result_1 =
  Tobogganator.go(tob, 0, 0, slope, 0) |> IO.inspect(label: "Total Trees 3:1")

slope2 = %{x: 1, y: 1}
result_2 =
  Tobogganator.go(tob, 0, 0, slope2, 0) |> IO.inspect(label: "Total Trees 1:1")

slope3 = %{x: 5, y: 1}
result_3 =
  Tobogganator.go(tob, 0, 0, slope3, 0) |> IO.inspect(label: "Total Trees 5:1")

slope4 = %{x: 7, y: 1}
result_4 =
  Tobogganator.go(tob, 0, 0, slope4, 0) |> IO.inspect(label: "Total Trees 7:1")

slope5 = %{x: 1, y: 2}
result_5 =
  Tobogganator.go(tob, 0, 0, slope5, 0) |> IO.inspect(label: "Total Trees 1:2")

result_1 * result_2 * result_3 * result_4 * result_5 |> IO.inspect(label: "Total")
