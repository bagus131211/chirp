defmodule ChirpWeb.PostLive.PostComponent do
  alias Chirp.Timeline
  use ChirpWeb, :live_component

  def render(assigns),
    do: ~H"""
    <div id={"post-#{@post.id}"} class="post border-b border-gray-200 p-4">
      <div class="flex items-start">
        <!-- Profile Avatar -->
        <div class="w-12 h-12 rounded-full bg-gray-300 mr-4"></div>
        <!-- Post Content -->
        <div class="flex-1">
          <div class="flex items-center justify-between">
            <!-- Username and Timestamp -->
            <div>
              <b class="text-gray-800">@<%= @post.username %></b>
              <span class="text-sm text-gray-500"> · 2h</span>
            </div>
          </div>
          <!-- Post Body -->
          <p class="text-gray-700 mt-2"><%= @post.body %></p>
          <!-- Post Actions -->
          <div class="flex items-center mt-4 text-gray-500 space-x-24">
            <a
              class="flex items-center space-x-2 cursor-pointer hover:text-red-500"
              href="#"
              phx-click="like"
              phx-target={@myself}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-5 h-5"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"
                />
              </svg>
               <span><%= @post.likes %></span>
            </a>
            
            <a
              class="flex items-center space-x-2 cursor-pointer hover:text-red-500"
              href="#"
              phx-click="repost"
              phx-target={@myself}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-5 h-5"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M17 1l4 4m0 0l-4 4m4-4H3m8 14l-4-4m0 0l4-4m-4 4h14"
                />
              </svg>
               <span><%= @post.reposts %></span>
            </a>
            <!-- Edit and Delete Buttons (Far Right) -->
            <div class="flex items-center space-x-24 ml-auto">
              <!-- Edit Button -->
              <.link
                patch={~p"/posts/#{@post.id}/edit"}
                class="flex items-center space-x-2 hover:text-blue-500"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="w-5 h-5"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M16.862 4.487a3.375 3.375 0 1 1 4.77 4.771L8.332 22.558a1.5 1.5 0 0 1-.548.343l-5.797 1.931a.375.375 0 0 1-.472-.472l1.932-5.797a1.5 1.5 0 0 1 .343-.548L16.862 4.487z"
                  />
                </svg>
                 <span>Edit</span>
              </.link>
              <!-- Delete Button -->
              <.link
                phx-click={JS.push("delete", value: %{id: @post.id}) |> hide("post-#{@post.id}")}
                data-confirm="Are you sure?"
                class="flex items-center space-x-2 hover:text-red-500"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="w-5 h-5"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M6 7h12M9 7v10m6-10v10m-8 0a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V7m-8 0V5a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2"
                  />
                </svg>
                 <span>Delete</span>
              </.link>
            </div>
          </div>
        </div>
      </div>
    </div>
    """

  def handle_event("like", _unsigned_params, socket) do
    Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _unsigned_params, socket) do
    Timeline.inc_repost(socket.assigns.post)
    {:noreply, socket}
  end
end
