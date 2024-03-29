defmodule  HdaHtmx.Contacts do
  use Agent

  def start_link(init) do
    Agent.start_link(fn -> init end, name: __MODULE__)
  end

  def contacts do
    Agent.get(__MODULE__, & &1)
  end

  def add(item) do
    Agent.update(__MODULE__, &([item |&1]))
  end

end
