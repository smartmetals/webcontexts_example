defmodule Bigapp.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :text
      add :author_id, references(:users, on_delete: :nothing)
      add :blog_post_id, references(:blog_posts, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:author_id])
    create index(:comments, [:blog_post_id])
  end
end
