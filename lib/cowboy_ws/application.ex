defmodule CowboyWs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised

    dispatch =
      :cowboy_router.compile([
        {:_,
         [
           {'/', :cowboy_static, {:priv_file, :cowboy_ws, 'index.html'}},
           {'/websocket', Handler, []},
           {'/static/[...]', :cowboy_static, {:priv_dir, :cowboy_ws, 'static'}}
         ]}
      ])

    {:ok, _} =
      :cowboy.start_clear(:http, [{:port, 8080}], %{
        :env => %{:dispatch => dispatch}
      })

    children = [
      # Starts a worker by calling: CowboyWs.Worker.start_link(arg)
      # {CowboyWs.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CowboyWs.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
