defmodule Bigapp.Content.BlogPost do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bigapp.Content.BlogPost


  schema "blog_posts" do
    field :content, :string
    field :title, :string
    field :author_id, :id

    timestamps()
  end

  @doc false
  def changeset(%BlogPost{} = blog_post, attrs) do
    blog_post
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
