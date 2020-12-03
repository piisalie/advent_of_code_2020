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

  def go(tob, start, slope, count \\ 0) do
    case at(tob, start.x, start.y) do
      "#" -> go(tob, %{x: start.x + slope.x, y: start.y + slope.y}, slope, count + 1)
      "." -> go(tob, %{x: start.x + slope.x, y: start.y + slope.y}, slope, count)
      nil -> count
    end
  end
end

tob =
  "input.txt"
  |> File.read!()
  |> Tobogganator.new()

start = %{x: 0, y: 0}
slope = %{x: 3, y: 1}
result_1 = Tobogganator.go(tob, start, slope) |> IO.inspect(label: "Total Trees 3:1")

slope2 = %{x: 1, y: 1}
result_2 = Tobogganator.go(tob, start, slope2) |> IO.inspect(label: "Total Trees 1:1")

slope3 = %{x: 5, y: 1}
result_3 = Tobogganator.go(tob, start, slope3) |> IO.inspect(label: "Total Trees 5:1")

slope4 = %{x: 7, y: 1}
result_4 = Tobogganator.go(tob, start, slope4) |> IO.inspect(label: "Total Trees 7:1")

slope5 = %{x: 1, y: 2}
result_5 = Tobogganator.go(tob, start, slope5) |> IO.inspect(label: "Total Trees 1:2")

(result_1 * result_2 * result_3 * result_4 * result_5) |> IO.inspect(label: "Total")
