defmodule HealthTracker.HealthStatsTest do
  use HealthTracker.DataCase

  alias HealthTracker.HealthStats
  alias HealthTracker.Factory
  alias HealthTracker.HealthStats.Weight
  alias HealthTracker.Accounts.User

  describe "weights" do
    alias HealthTracker.HealthStats.Weight

    import HealthTracker.HealthStatsFixtures

    @invalid_attrs %{weight: nil}

    test "is valid from the factory" do
      new_weight = Factory.params_for(:weight)
      changeset = Weight.changeset(%Weight{}, new_weight)
      assert changeset.valid? || (IO.inspect(changeset.errors) && false)
    end

    test "list_weights/0 returns all weights" do
      weight = Factory.insert(:weight)
      assert HealthStats.list_weights() == [weight]
    end

    test "get_weight!/1 returns the weight with given id" do
      weight = Factory.insert(:weight)
      assert HealthStats.get_weight!(weight.id) == weight
    end

    test "create_weight/1 with valid data creates a weight" do
      user = Factory.insert(:user)
      valid_attrs = %{weight: 120.5, user_id: user.id}

      assert {:ok, %Weight{} = weight} = HealthStats.create_weight(valid_attrs)
      assert weight.weight == 120.5
    end

    test "create_weight/1 with invalid data returns error changeset" do
      user = Factory.insert(:user)
      assert {:error, %Ecto.Changeset{}} = HealthStats.create_weight(@invalid_attrs)
    end

    test "update_weight/2 with valid data updates the weight" do
      weight = Factory.insert(:weight)
      update_attrs = %{weight: 456.7}

      assert {:ok, %Weight{} = weight} = HealthStats.update_weight(weight, update_attrs)
      assert weight.weight == 456.7
    end

    test "update_weight/2 with invalid data returns error changeset" do
      user = Factory.insert(:user)
      weight = Factory.insert(:weight)
      weight = Factory.insert(:weight, user_id: user.id)
      assert {:error, %Ecto.Changeset{}} = HealthStats.update_weight(weight, @invalid_attrs)
      assert weight == HealthStats.get_weight!(weight.id)
    end

    test "delete_weight/1 deletes the weight" do
      weight = Factory.insert(:weight)
      assert {:ok, %Weight{}} = HealthStats.delete_weight(weight)
      assert_raise Ecto.NoResultsError, fn -> HealthStats.get_weight!(weight.id) end
    end

    test "change_weight/1 returns a weight changeset" do
      weight = Factory.insert(:weight)
      assert %Ecto.Changeset{} = HealthStats.change_weight(weight)
    end

    test "get_weight_values_for_user/1 returns all weights for a user" do
      user = Factory.insert(:user)
      weight = Factory.insert(:weight, user_id: user.id, weight: 80.4)
      weight = Factory.insert(:weight, user_id: user.id, weight: 81.4)
      weight = Factory.insert(:weight, user_id: user.id, weight: 82.4)

      assert HealthStats.Weight.get_weight_values_for_user(user.id) == [80.4, 81.4, 82.4]
    end
  end
end
