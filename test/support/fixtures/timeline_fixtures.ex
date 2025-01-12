defmodule Chirp.TimelineFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chirp.Timeline` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        likes: 42,
        reposts: 42,
        username: "some username"
      })
      |> Chirp.Timeline.create_post()

    post
  end
end
