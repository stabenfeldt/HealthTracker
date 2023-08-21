defmodule HealthTracker.HealthStats do
  @moduledoc """
  The HealthStats context.
  """

  import Ecto.Query, warn: false
  alias HealthTracker.Repo

  alias HealthTracker.HealthStats.Weight

  @doc """
  Returns the list of weights.

  ## Examples

      iex> list_weights()
      [%Weight{}, ...]

  """
  def list_weights do
    Repo.all(Weight)
  end

  @doc """
  Gets a single weight.

  Raises `Ecto.NoResultsError` if the Weight does not exist.

  ## Examples

      iex> get_weight!(123)
      %Weight{}

      iex> get_weight!(456)
      ** (Ecto.NoResultsError)

  """
  def get_weight!(id), do: Repo.get!(Weight, id)

  @doc """
  Creates a weight.

  ## Examples

      iex> create_weight(%{field: value})
      {:ok, %Weight{}}

      iex> create_weight(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_weight(user_id, attrs \\ %{}) do
    %Weight{}
    |> Map.put(:user_id, user_id)
    |> Weight.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a weight.

  ## Examples

      iex> update_weight(weight, %{field: new_value})
      {:ok, %Weight{}}

      iex> update_weight(weight, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_weight(%Weight{} = weight, attrs) do
    # |> Map.put(:user_id, current_user_id)
    weight
    |> Weight.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a weight.

  ## Examples

      iex> delete_weight(weight)
      {:ok, %Weight{}}

      iex> delete_weight(weight)
      {:error, %Ecto.Changeset{}}

  """
  def delete_weight(%Weight{} = weight) do
    Repo.delete(weight)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking weight changes.

  ## Examples

      iex> change_weight(weight)
      %Ecto.Changeset{data: %Weight{}}

  """
  def change_weight(%Weight{} = weight, attrs \\ %{}) do
    Weight.changeset(weight, attrs)
  end
end
