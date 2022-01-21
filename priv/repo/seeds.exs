# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Blog.{Repo, Posts.Post}

phoenix = Post.changeset %Post{}, %{title: "Phoenix framework", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi bibendum elit eu imperdiet egestas. Phasellus consectetur nisl blandit, dapibus odio sed, dignissim augue. Praesent nec nisi metus. Cras rhoncus lacinia nisi, ac ultricies quam iaculis ut."}
elixir = Post.changeset %Post{}, %{title: "Elixir", description: "
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi bibendum elit eu imperdiet egestas. Phasellus consectetur nisl blandit, dapibus odio sed, dignissim augue. Praesent nec nisi metus. Cras rhoncus lacinia nisi, ac ultricies quam iaculis ut."}
live_view = Post.changeset %Post{}, %{title: "Live view", description: "
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi bibendum elit eu imperdiet egestas. Phasellus consectetur nisl blandit, dapibus odio sed, dignissim augue. Praesent nec nisi metus. Cras rhoncus lacinia nisi, ac ultricies quam iaculis ut."}


Repo.insert(phoenix)
Repo.insert(elixir)
Repo.insert(live_view)
