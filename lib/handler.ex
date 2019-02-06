defmodule Handler do
  def init(req, opts) do
    {:cowboy_websocket, req, opts}
  end

  def websocket_init(state) do
    :erlang.start_timer(1000, self(), "Hello!")
    {:ok, state}
  end

  def websocket_handle({:text, msg}, state) do
    {:reply, {:text, "That's what she said! " <> msg}, state}
  end

  def websocket_handle(_data, state) do
    {:ok, state}
  end

  def websocket_info({:timeout, _ref, msg}, state) do
    :erlang.start_timer(1000, self(), "How' you doin'?")
    {:reply, {:text, msg}, state}
  end

  def websocket_info(_info, state) do
    {:ok, state}
  end
end
