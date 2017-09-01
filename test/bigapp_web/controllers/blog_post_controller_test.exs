defmodule BigappWeb.BlogPostControllerTest do
  use BigappWeb.ConnCase

  alias Bigapp.Content

  @create_attrs %{content: "some content", title: "some title"}
  @update_attrs %{content: "some updated content", title: "some updated title"}
  @invalid_attrs %{content: nil, title: nil}

  def fixture(:blog_post) do
    {:ok, blog_post} = Content.create_blog_post(@create_attrs)
    blog_post
  end

  describe "index" do
    test "lists all blog_posts", %{conn: conn} do
      conn = get conn, blog_post_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Blog posts"
    end
  end

  describe "new blog_post" do
    test "renders form", %{conn: conn} do
      conn = get conn, blog_post_path(conn, :new)
      assert html_response(conn, 200) =~ "New Blog post"
    end
  end

  describe "create blog_post" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, blog_post_path(conn, :create), blog_post: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == blog_post_path(conn, :show, id)

      conn = get conn, blog_post_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Blog post"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, blog_post_path(conn, :create), blog_post: @invalid_attrs
      assert html_response(conn, 200) =~ "New Blog post"
    end
  end

  describe "edit blog_post" do
    setup [:create_blog_post]

    test "renders form for editing chosen blog_post", %{conn: conn, blog_post: blog_post} do
      conn = get conn, blog_post_path(conn, :edit, blog_post)
      assert html_response(conn, 200) =~ "Edit Blog post"
    end
  end

  describe "update blog_post" do
    setup [:create_blog_post]

    test "redirects when data is valid", %{conn: conn, blog_post: blog_post} do
      conn = put conn, blog_post_path(conn, :update, blog_post), blog_post: @update_attrs
      assert redirected_to(conn) == blog_post_path(conn, :show, blog_post)

      conn = get conn, blog_post_path(conn, :show, blog_post)
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, blog_post: blog_post} do
      conn = put conn, blog_post_path(conn, :update, blog_post), blog_post: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Blog post"
    end
  end

  describe "delete blog_post" do
    setup [:create_blog_post]

    test "deletes chosen blog_post", %{conn: conn, blog_post: blog_post} do
      conn = delete conn, blog_post_path(conn, :delete, blog_post)
      assert redirected_to(conn) == blog_post_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, blog_post_path(conn, :show, blog_post)
      end
    end
  end

  defp create_blog_post(_) do
    blog_post = fixture(:blog_post)
    {:ok, blog_post: blog_post}
  end
end
