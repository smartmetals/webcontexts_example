defmodule Bigapp.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bigapp.Content.Comment


  schema "comments" do
    field :content, :string
    field :author_id, :id
    field :blog_post_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
