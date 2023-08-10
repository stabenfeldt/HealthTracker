defmodule HealthTracker.FeatureCase do
  use ExUnit.CaseTemplate

  use HealthTrackerWeb.ConnCase
  # use HealthTracker.DataCase

  using do
    quote do
      use Wallaby.DSL
      alias HealthTracker.Router.Helpers, as: Routes

      @endpoint HealthTracker.Endpoint
    end
  end

  setup tags do
    #  pid = Ecto.Adapters.SQL.Sandbox.start_owner!(HealthTracker.Repo, shared: not tags[:async])
    #  on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)

    #  # :ok = Ecto.Adapters.SQL.Sandbox.checkout(HealthTracker.Repo)

    #  # unless tags[:async] do
    #  #  Ecto.Adapters.SQL.Sandbox.mode(HealthTracker.Repo, {:shared, self()})
    #  # end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(HealthTracker.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
