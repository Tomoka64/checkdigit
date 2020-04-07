defmodule Runner do
  use GenServer

  def start_link do
    state = %{done: []}
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def verify(commands) do
    GenServer.call(__MODULE__, {:verify, commands})
  end

  def handle_call({:verify, commands}, _from, state) do
    commands = List.wrap(commands)

    Enum.each(commands, fn {mod, args} ->
      result = apply(mod, :verify, List.wrap(args))
      IO.puts "#{args}: #{result}"
    end)

    new_state = %{state | done: Enum.reverse(commands) ++ state.done}
    IO.inspect new_state
    {:reply, :ok, new_state}
  end
end