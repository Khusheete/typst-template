// Copyright 2025 Ferdinand Souchet (aka. @Khusheete)
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the “Software”)
// , to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.


#let todo_state = state("todos", ())


#let todo(message) = context {
  let current_page = counter(page).at(here()).last()
  let prev_headings = query(selector(heading).before(here()))
  let current_heading = if prev_headings.len() > 0 {
    prev_headings.last()
  }
  let location = here()

  // Add to the todo state
  todo_state.update(
    todos => todos + ((page: current_page, heading: current_heading, location: location, message: message),)
  )

  set text(fill: red, weight: "bold")
  [TODO: #message]
}


#let has_todos() = {
  let todos = todo_state.at(here())
  return todos.len() >= 1
}


#let todo_list() = context {
  let todos = todo_state.at(here())
  if todos.len() >= 1 {
    for todo in todos {
      link(todo.location)[#underline[Page #todo.page - #todo.heading.numbering #todo.heading.body]: #todo.message \ ]
    }
  }
}
