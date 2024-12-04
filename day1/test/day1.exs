# anonymous function
#distanceBetweenElements = fn
#    e1, e2 -> abs(e1-e2)
#end

# capture function
#distanceBetweenNums = &(abs(&1 - &2))

#IO.puts("list1=#{inspect(list1)}")
#IO.puts("list2=#{inspect(list2)}")

#IO.puts("Distance between 1 and 3 is #{inspect(distanceBetweenElements.(1, 3))}")
#IO.puts("Distance between 1 and 3 is #{inspect(distanceBetweenNums.(1, 3))}")


defmodule Day1 do
  def distance(a, b) do
    abs(a - b)
  end

  def sum_distances([head1 | tail1], [head2 | tail2]) do
    #IO.puts("Tail1=#{inspect(tail1)}\nTail2=#{inspect(tail2)}\n")
    sum_distances(tail1, tail2) + distance(head1, head2)
  end

  def sum_distances([], []) do
    0
  end

  def sum_occurences([headLeft | tailLeft], listRight) do
    count = Enum.count(listRight, fn x -> x === headLeft end)
    #IO.puts("Element #{inspect(headLeft)} occurs in #{inspect(listRight)} #{inspect(count)}")

    count * headLeft + sum_occurences(tailLeft, listRight)
  end

  def sum_occurences([], _listRight) do
    0
  end
end

list1 = [3, 4, 2, 1, 3, 3]
list2 = [4, 3, 5, 3, 9, 3]

list1 = Enum.sort(list1)
list2 = Enum.sort(list2)

IO.puts("Sum of distances between list1 and list2 is #{inspect(Day1.sum_distances(list1, list2))}\n")

IO.puts("Similarity score is #{inspect(Day1.sum_occurences(list1, list2))}\n")

{:ok, fileContent} = File.read("input")
split = String.split(fileContent, "\n", trim: true)

pairList = Enum.map(split, & String.split(&1, " ", trim: true))
flattenToSingleList = Enum.flat_map(pairList, & List.flatten(&1))
                      |> Enum.map(&String.to_integer/1)

listOne = Stream.take_every(flattenToSingleList, 2)
          |> Enum.to_list
          |> Enum.sort

listTwo = flattenToSingleList -- listOne
|> Enum.to_list
|> Enum.sort


#IO.puts("List one freq: #{inspect(Enum.frequencies(listOne))}\n")
#IO.puts("List two freq: #{inspect(Enum.frequencies(listTwo))}\n")

#IO.puts("List one: #{inspect(listOne)}\n Length=#{inspect(length(listOne))}\n")
#IO.puts("List two: #{inspect(listTwo)}\n Length=#{inspect(length(listOne))}\n")


IO.puts("Sum of distances between listOne and listTwo is #{inspect(Day1.sum_distances(listOne, listTwo))}")

IO.puts("Similarity score is #{inspect(Day1.sum_occurences(listOne, listTwo))}")
