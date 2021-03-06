// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import {Socket} from "phoenix"

// And connect to the path in "lib/blog_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/blog_web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/blog_web/templates/layout/app.html.heex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/blog_web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1_209_600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()

// Now that you are connected, you can join channels with a topic.
// Let's assume you have a channel with a topic named `room` and the
// subtopic is its id - in this case 42:
const createSocket = (post_id) => {
  let btnComment = document.getElementById("btn-comment")
  let textAreaComment = document.getElementById("comment-text")
  let channel = socket.channel(`comments:${post_id}`, {})
  channel.join()
    .receive("ok", resp => {
      getComments(resp.comments)
    })
    .receive("error", resp => { console.log("Unable to join", resp) })

    channel.on(`comments:${post_id}:new`, includComment)
    btnComment.addEventListener("click", () => {
      let content = textAreaComment.value
      channel.push("comment:add", {content})
      textAreaComment.value = ""
    })

}

const includComment = ({ comment }) => {
 console.log(comment)
 document.querySelector(".collection").innerHTML += commentsTemplate(comment)
}

const getComments = (comments) => {
  const commentsList = comments.map(comment => {
    return commentsTemplate(comment);
  })

  document.querySelector(".collection").innerHTML = commentsList.join('')
}

const commentsTemplate = (comment) => {
  return `
  <li class="collection-item avatar">
    <i class="material-icons circle red">play_arrow</i>
    <span class="title">Title</span>
    <p>
      ${comment.content}
    </p>
  </li>
  `
}

window.createSocket = createSocket
