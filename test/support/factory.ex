defmodule HealthTracker.Factory do
  use ExMachina.Ecto, repo: HealthTracker.Repo

  def user_factory do
    password = "top-secret-123"

    %HealthTracker.Accounts.User{
      email: Faker.Internet.email(),
      password: password,
      hashed_password: Bcrypt.hash_pwd_salt(password)
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
