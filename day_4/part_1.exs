# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID) -- optional

defmodule PassportValue do
  @eye_colors ~w[amb blu brn gry grn hzl oth]

  def valid?(value) do
    value |> String.split(":") |> validate
  end

  defp validate(["byr", value]) do
    value = String.to_integer(value)
    value >= 1920 && value <= 2002
  end

  defp validate(["iyr", value]) do
    value = String.to_integer(value)
    value >= 2010 && value <= 2020
  end

  defp validate(["eyr", value]) do
    value = String.to_integer(value)
    value >= 2020 && value <= 2030
  end

  defp validate(["hgt", value]) do
    ~r/(?<height>\d+)(?<unit>[in|cm]+)/
    |> Regex.named_captures(value)
    |> validate_height
  end

  defp validate(["hcl", value]) do
    value |> String.match?(~r/#[0-9a-f]{6}/)
  end

  defp validate(["ecl", value]) when value in @eye_colors do
    true
  end

  defp validate(["pid", value]) do
    value |> String.match?(~r/\d{9}/)
  end

  defp validate(["cid", _value]) do
    true
  end

  defp validate(_) do
    false
  end

  defp validate_height(%{"height" => h, "unit" => "in"}) do
    value = String.to_integer(h)
    value >= 59 && value <= 76
  end

  defp validate_height(%{"height" => h, "unit" => "cm"}) do
    value = String.to_integer(h)
    value >= 150 && value <= 193
  end

  defp validate_height(_) do
    false
  end

end

passports =
  "input.txt"
  |> File.read!
  |> String.split("\n\n")

has_required_fields =
  passports
  |> Enum.filter(fn line ->
  original_length =
    line
    |> String.length

  new_length =
    line
    |> String.replace(
    ~r/(byr:)|(iyr:)|(eyr:)|(hgt:)|(hcl:)|(ecl:)|(pid:)/,
  "",
  global: true)
  |> String.length

    original_length - new_length == 28
  end)

has_required_fields
|> length
|> IO.inspect(label: "Part 1 -- has required fields")


has_required_fields
|> Enum.filter(fn line ->
  line
  |> String.split(~r/\s+/)
  |> Enum.all?(&PassportValue.valid?/1)
end)
|> length
|> IO.inspect(label: "Part 2 -- has valid entries")
