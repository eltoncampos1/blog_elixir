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
alias Blog.{Accounts, Accounts.User, Posts, Posts.Post}

user = %{
  email: "eltoncampos36@gmail.com",
  first_name: nil,
  image: "https://lh3.googleusercontent.com/a/default-user=s96-c",
  provider: "google",
  token:
    "ya29.A0ARrdaM-NqSvnASKQGLZnmpunvPqqbvPidU6rUg7Mw_0ELJPQOkfw9u6skF4m-rJ54XAIHk3JpmfluUkUXQvyfkFdQV-51gJYK6V7DrM2uQs5iDP-i9LpJBVKIWAakU22NNCj6UcgBf8c8rF9q2cmTP5uTnCNfw"
}

phoenix = %{
  title: "Phoenix framework",
  description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi bibendum elit eu imperdiet egestas. Phasellus consectetur nisl blandit, dapibus odio sed, dignissim augue. Praesent nec nisi metus. Cras rhoncus lacinia nisi, ac ultricies quam iaculis ut."
}

{:ok, user} = Blog.Accounts.create_user(user)
{:ok, phoenix} = Posts.create_post(user, phoenix)
