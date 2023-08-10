defmodule HealthTracker.Factory do
  use ExMachina.Ecto, repo: HealthTracker.Repo

  def user_factory do
    %HealthTracker.Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "topsecret",
      hashed_password: Bcrypt.hash_pwd_salt("topsecret")
    }
  end

  def weight_factory do
    user = insert(:user)
    IO.puts("weight_factory")
    # IO.puts("user: #{inspect(user)}")

    %HealthTracker.HealthStats.Weight{
      weight: sequence(:weight, & &1),
      user_id: 1
      # date: sequence(:date, & &1)
    }
  end
end
