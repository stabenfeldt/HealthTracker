defmodule HealthTracker.Factory do
  use ExMachina.Ecto, repo: HealthTracker.Repo

  def user_factory do
    %HealthTracker.Accounts.User{
      email: Faker.Internet.email(),
      password: "topsecret",
      hashed_password: Bcrypt.hash_pwd_salt("topsecret")
    }
  end

  def weight_factory do
    user = insert(:user)
    IO.puts("weight_factory")

    %HealthTracker.HealthStats.Weight{
      weight: sequence(:weight, & &1),
      user_id: user.id
    }
  end
end
