import gleam/io
import gleam/erlang/process

pub fn main() {
  // Create a new subject the child can listen on
  let sub = process.new_subject()

  // Spawn the child process, passing the subject
  let _child = process.spawn(fn() {
    let msg = process.receive(from: sub, within: 0)
    case msg {
      Ok(m) -> io.println("Child process got: " <> m)
      Error(_) -> io.println("No message received")
    }
  })

  // Send from main to the subject
  process.send(sub, "Hello from main!")
}
