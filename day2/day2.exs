defmodule Day2 do
  @doc """
  Is the difference between two numbers between 1 and 3 (inclusive)
  """
  def diffBetweenOneAndThree?([head | tail]) do
    diffBetweenOneAndThree?(head, tail)
  end

  def diffBetweenOneAndThree?(_a) do
    true
  end

  def diffBetweenOneAndThree?(a, [head | tail]) do
    diff = abs(a-head)
    diff >= 1 and diff <= 3 and diffBetweenOneAndThree?(head, tail)
  end

  def diffBetweenOneAndThree?(a, []) do
    diffBetweenOneAndThree?(a)
  end

  @doc """
  Are all the elements in this list increasing?
  """
  def increasing?([head | tail]) do
    increasing?(head, tail)
  end

  def increasing?(_a) do
    true
  end

  def increasing?(a, [head | tail]) do
    (a-head)<0 and increasing?(head, tail)
  end

  def increasing?(a, []) do
    increasing?(a)
  end

  @doc """
  Are all the elements in this list decreasing?
  """
  def decreasing?([head | tail]) do
    decreasing?(head, tail)
  end

  def decreasing?(_a) do
    true
  end

  def decreasing?(a, []) do
    decreasing?(a)
  end

  def decreasing?(a, [head | tail]) do
    (a-head)>0 and decreasing?(head, tail)
  end

  def reportSafe?(list) do
    (increasing?(list) or decreasing?(list))
    and diffBetweenOneAndThree?(list)
  end
end

# r1 = [7, 6, 4, 2, 1]
# r2 = [1, 2, 7, 8, 9]
# r3 = [9, 7, 6, 2, 1]
# r4 = [1, 3, 2, 4, 5]
# r5 = [8, 6, 4, 4, 1]
# r6 = [1, 3, 6, 7, 9]

# IO.puts("Is #{inspect(r1)} safe? #{inspect(Day2.reportSafe?(r1))}")
# IO.puts("Is #{inspect(r2)} safe? #{inspect(Day2.reportSafe?(r2))}")
# IO.puts("Is #{inspect(r3)} safe? #{inspect(Day2.reportSafe?(r3))}")
# IO.puts("Is #{inspect(r4)} safe? #{inspect(Day2.reportSafe?(r4))}")
# IO.puts("Is #{inspect(r5)} safe? #{inspect(Day2.reportSafe?(r5))}")
# IO.puts("Is #{inspect(r6)} safe? #{inspect(Day2.reportSafe?(r6))}")


# x = IO.read(:stdio, :eof) # call program as "elixir prog.exs < input.file"
{:ok, fileContent} = File.read("input")
reports = String.split(fileContent, "\n", trim: true)

cnt = Enum.count(reports, fn report ->
  String.split(report, " ", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Day2.reportSafe?()
end)

IO.inspect(cnt, label: "Safe reports")

defmodule Day2_2 do
  @doc """
  Are all the elements in this list increasing?
  """
  def increasing?([head | tail]) do
    increasing?(head, tail)
  end

  def increasing?(_a) do
    true
  end

  def increasing?({a, ia}, [{head, ih} | tail]) do
    diff = a - head
    if diff <= -1 and diff >= -3 do
      increasing?({head, ih}, tail)
    else
      [ia, ih]
    end
  end

  def increasing?(a, []) do
    increasing?(a)
  end

  @doc """
  Are all the elements in this list decreasing?
  """
  def decreasing?([head | tail]) do
    decreasing?(head, tail)
  end

  def decreasing?(_a) do
    true
  end

  def decreasing?(a, []) do
    decreasing?(a)
  end

  def decreasing?({a, ia}, [{head, ih} | tail]) do
    diff = a - head
    if diff >= 1 and diff <= 3 do
      decreasing?({head, ih}, tail)
    else
      [ia, ih]
    end
  end

  def reportSafe?(list, failed) do
    incr = increasing?(Enum.with_index(list))
    decr = decreasing?(Enum.with_index(list))

    # IO.puts("============entered function=========")
    # IO.inspect(incr, charlists: :as_lists, label: "incr")
    # IO.inspect(decr, charlists: :as_lists, label: "decr")
    # IO.inspect(list, charlists: :as_lists, label: "list")

    cond do
      !is_list(incr) -> true
      !is_list(decr) -> true
      failed -> false
      true ->
        reportSafe?(List.delete_at(list, List.first(incr)), true) or
        reportSafe?(List.delete_at(list, List.last(incr)), true) or
        reportSafe?(List.delete_at(list, List.first(decr)), true) or
        reportSafe?(List.delete_at(list, List.last(decr)), true)
    end
  end
end

cnt = Enum.count(reports, fn report ->
  l = String.split(report, " ", trim: true)
  |> Enum.map(&String.to_integer/1)

  Day2_2.reportSafe?(l, false)
end)
IO.inspect(cnt, label: "Safe reports with tolerance")

############################ DEBUG - IGNORE ################################################
# IO.puts("Is #{inspect(r1)} safe? #{inspect(Day2_2.reportSafe?(r1, false))}")
# IO.puts("Is #{inspect(r2)} safe? #{inspect(Day2_2.reportSafe?(r2, false))}")
# IO.puts("Is #{inspect(r3)} safe? #{inspect(Day2_2.reportSafe?(r3, false))}")
# IO.puts("Is #{inspect(r4)} safe? #{inspect(Day2_2.reportSafe?(r4, false))}")
# IO.puts("Is #{inspect(r5)} safe? #{inspect(Day2_2.reportSafe?(r5, false))}")
# IO.puts("Is #{inspect(r6)} safe? #{inspect(Day2_2.reportSafe?(r6, false))}")

# rfail = [54, 57, 60, 62, 66]
# rfail2 = [74, 72, 69, 68, 67, 63]
# rfail3 = [80, 77, 74, 73, 72, 67]
# rfail4 = [84, 81, 80, 76, 78]
# rfail5 = [49, 51, 52, 54, 51]
# rfail6 = [35, 36, 39, 36, 40]
# rfail7 = [67, 64, 62, 61, 57]
# rfail8 = [74, 72, 71, 68, 65, 59]
# rfail9 = [51, 50, 47, 45, 42, 41, 34]

# IO.puts("Is #{inspect(rfail, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(rfail, false))}")
# IO.puts("Is #{inspect(rfail2, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(rfail2, false))}")
# IO.puts("Is #{inspect(rfail3, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(rfail3, false))}")
# IO.puts("Is #{inspect(rfail4, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(rfail4, false))}")
# IO.puts("Is #{inspect(rfail5, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(rfail5, false))}")
# IO.puts("Is #{inspect(rfail6, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(rfail6, false))}")
# IO.puts("Is #{inspect(rfail7, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(rfail7, false))}")
# IO.puts("Is #{inspect(rfail8, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(rfail8, false))}")
# IO.puts("Is #{inspect(rfail9, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(rfail9, false))}")

#withoutLastElement = rfail |> Enum.reverse() |> tl() |> Enum.reverse()
#IO.puts("Is #{inspect(withoutLastElement, charlists: :as_lists)} safe? #{inspect(Day2_2.reportSafe?(withoutLastElement, false))}")

# cnt = Enum.count(reports, fn report ->
#   l = String.split(report, " ", trim: true)
#   |> Enum.map(&String.to_integer/1)

#   if !Day2_2.reportSafe?(l, false) do
#     IO.puts("END LIST #{inspect(l, charlists: :as_lists)}: #{inspect(Day2_2.reportSafe?(l, false))}")
#   end
# end)

# IO.inspect(cnt, label: "Safe reports by tolerating one bad level")
