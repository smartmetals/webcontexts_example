defmodule Bigapp.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string
      add :content, :text
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:blog_posts, [:author_id])
  end
end
