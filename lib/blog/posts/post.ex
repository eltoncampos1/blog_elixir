defmodule Blog.Posts.Post do
  @moduledoc """
  Post schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:title, :description]

  schema "posts" do
    field :title, :string
    field :description, :string

    timestamps()
  end

  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:title, :description])
    |> validate_required(@required_params)
  end
end
