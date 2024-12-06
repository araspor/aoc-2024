defmodule D3P1 do
  def extractInstructions(string) do
    Regex.scan(~r/mul\(\d{1,3},\d{1,3}\)/, string, include_captures: true)
    #|> IO.inspect(charlists: :as_lists)
    |> Enum.map(&hd/1)
    #|> IO.inspect() # ["mul(2,4)", "mul(5,5)", "mul(11,8)", "mul(8,5)"]
  end

  def doInstruction(instr) do
    Regex.scan(~r/\d{1,3}/, instr, include_captures: true)
    |> Enum.map(&hd/1)
    #|> IO.inspect() # ["2", "4"]
    |> Enum.map(&String.to_integer/1)
    |> multiplyListElements()
    #|> IO.inspect(charlists: :as_lists)
  end

  def multiplyListElements([head | tail]) do
    head * multiplyListElements(tail)
  end

  def multiplyListElements([]) do
    1
  end

  def processInput(input) do
    extractInstructions(input)
    |> Enum.map(&doInstruction/1)
    |> Enum.sum()
  end
end

#instr = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

file = IO.read(:stdio, :eof) # call program as "elixir prog.exs < input.file"
IO.inspect(D3P1.processInput(file))


defmodule D3P2 do
  def extractInstructions(string) do
    Regex.scan(~r/(mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\))/, string, include_captures: true)
    #|> IO.inspect(charlists: :as_lists)
    |> Enum.map(&hd/1)
    #|> IO.inspect() # ["mul(2,4)", "don't()", "mul(5,5)", "mul(11,8)", "do()", "mul(8,5)"]
  end

  def processInstructions([head | tail], doMultiply) do
    cond do
      doMultiply and head =~ "mul" ->
        D3P1.doInstruction(head) + processInstructions(tail, true)
      head == "do()" ->
        processInstructions(tail, true)
      head == "don't()" ->
        processInstructions(tail, false)
      true -> processInstructions(tail, doMultiply)
    end
  end

  def processInstructions([], _doMultiply) do
    0
  end

  def processInput(input) do
    extractInstructions(input)
    |> processInstructions(true)
    #|> Enum.map(&doInstruction/1)
    #|> Enum.sum()
  end
end

#test = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
#IO.inspect(D3P2.processInput(test))

IO.inspect(D3P2.processInput(file))
