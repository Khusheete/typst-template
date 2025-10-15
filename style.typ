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



#import "utils/math.typ": *
#import "utils/ga.typ"
#import "utils/propbox.typ": *
#import "utils/todos.typ": *


// ================
// = Translations =
// ================


#let _style_translation = (
 code: (
  fr: "Code",
  en: "Code",
 ),
)


#let _stl_tr(key) = _style_translation.at(key).at(text.lang)


// =============
// = Constants =
// =============


#let dark_gray = gray.darken(35%)


// ====================
// = Helper functions =
// ====================


#let _heading_numbering(depth, counter) = {
 if depth == 1 {
  numbering("I.", counter)
 } else if depth == 2 {
  numbering("1.", counter)
 } else if depth == 3 {
  numbering("a.", counter)
 }
}

#let get_page_header(current_page) = {
 let before_page(header) = {
  header.location().page() - 1 <= current_page
 }
 let on_page(header) = {
  header.location().page() - 1 == current_page
 }
 let headers = query(
  heading.where(level: 1)
 )
 let on_page_headers = headers.filter(on_page)

 if on_page_headers.len() > 0 {
  let header = on_page_headers.first()
  let header_counter = counter(heading).at(header.location()).last()

  return [#_heading_numbering(1, header_counter) #header.body]
 }
 let before_page_headers = headers.filter(before_page)
 if before_page_headers.len() > 0 {
  let header = before_page_headers.last()
  let header_counter = counter(heading).at(header.location()).last()
  return [#header.body]
 }
}


#let show_todo_list() = context {
 if (has_todos()) [
  #linebreak()
 
  = TODOs

  #todo_list()
 ]
}


// ==================
// = Sub-show rules =
// ==================


#let _styling(body) = {
 show ref: it => {
  let element = it.element
  if element == none {
   return it
  }

  let number = counter(element.func()).at(element.location()).last()
  let number_content = numbering(element.numbering, number)


  let func = element.func()
  if func == math.equation {
   link(element.location(), number_content)
  } else { // TODO: add figure when not propbox
   it
  }
 }

 set heading(numbering: "I.1.a.")
 show heading: it => {
  let depth = it.depth
  let count = counter(heading).get().last()

  [
   #_heading_numbering(depth, count) #it.body
  ]
 }

 // Code formatting
 show raw.where(block: true): it => {
  set align(top + left)

  block(
   stroke: 1.2pt + black,
   breakable: true,
   inset: (top: 2pt, bottom: 2pt),
   width: 100%,
   radius: 3pt,
   grid(
    columns: 2,
    column-gutter: 12pt,
    inset: 0.3em,
    stroke: (x, y) => if x == 0 {(right: dark_gray,)},

    ..it.lines.map(
     line => (
      align(top + right, text(fill: dark_gray, [#line.number])),
      [#line.body],
     )
    ).flatten()
   )
  )
 }

 show raw.where(block: false): it => {
  box(
   fill: aqua.lighten(75%),
   radius: 2pt,
   inset: 1pt,
   baseline: 10%,
   [*#it.text*]
  )
 }

 // Link formatting
 show link: it => text(stroke: aqua, underline(it))

 // Figure formatting
 show figure.where(kind: raw): set figure(supplement: [#context _stl_tr("code")])

 // Body
 body
}


// =============
// = Templates =
// =============


#let paper_template(
 body,
 author: none,
 co_authors: none,
 contact: none,
 title: none,
 short_title: none,
 subtitle: none,
 cover_page: true,
 paper: "a4",
 lang: "en",
) = {
 // ===========
 // = Styling =
 // ===========
 show: _styling
 set text(lang: lang)
 set par(justify: true)


 // ==============
 // = Cover Page =
 // ==============
 counter(page).update(0)

 if cover_page == true {
  v(1fr)

  set par(justify: false)

  align(center)[
   #set text(size: 28pt, weight: "semibold")
   #title

   #if subtitle != none {
    v(-0.5em)
    set text(size: 16pt, weight: "regular")
    emph(subtitle)
   }
  ]

  line(start: (42%, 0%), length: 16%)

  align(center)[
   #set text(size: 16pt)
   #author
   #if contact != none {
    v(-0.2em)
    set text(size: 14pt)
    contact
   }
  ]

  line(start: (12.5%, 0%), length: 75%)

  v(3em)

  {
   show outline.entry: it => {
    let heading_depth = it.element.depth
    let heading_count = counter(heading).at(it.element.location()).last()

    link(
     it.element.location(),
     it.indented(_heading_numbering(heading_depth, heading_count), it.inner()),
    )
   }
   outline(
    title: none,
   )
  }

  v(2fr)

  pagebreak()
 } else if type(cover_page) == content {
  cover_page
  pagebreak()
 }


 // ======================
 // = Page Configuration =
 // ======================

 set page(
  paper: paper,
  header: context {
   set par(justify: false)
   let current_page = counter(page).at(here()).first()

   if current_page > 0 {
    grid(
     columns: (1fr, 1fr),

     align(left, {
      if short_title != none {
       short_title
      } else {
       title
      }
     }),

     align(right, context get_page_header(current_page))
    )

    v(-0.8em)
    line(length: 100%)
   }
  },
  footer: context {
   set par(justify: false)
   let current_page = counter(page).at(here()).last()

   if current_page > 0 {
    line(length: 100%)
    v(-0.5em)
    grid(
     columns: (1fr, 1fr, 1fr),
     align(left, author),
     context {
      let final_page = counter(page).final().last()
      align(center)[#(current_page) / #(final_page)]
     },
     align(right, contact)
    )
   }
  }
 )


 // ========================
 // = Display Content Body =
 // ========================

 body


 // =================
 // = Display TODOs =
 // =================

 show_todo_list()
}


#let cheatsheet_template(
 body,
 author: none,
 contact: none,
 title: none,
 short_title: none,
 subtitle: none,
 paper: "a4",
 lang: "en",
) = {
 // ===========
 // = Styling =
 // ===========
 show: _styling
 set text(lang: lang, size: 9pt)
 set par(spacing: 0.85em, leading: 0.3em, justify: true)

 // ======================
 // = Page Configuration =
 // ======================
 set page(
  paper: paper,
  flipped: true,
  margin: (left: 6.35mm, right: 6.35mm, top: 15mm, bottom: 15mm),
  columns: 3,
  header: context {
   set par(justify: false)
   let current_page = counter(page).at(here()).first()

   if current_page > 0 {
    grid(
     columns: (1fr, 1fr),

     align(left, {
      if short_title != none {
       short_title
      } else {
       title
      }
     }),

     // align(right, context get_page_header(current_page))
    )

    v(-0.8em)
    line(length: 100%)
   }
  },
  footer: context {
   set par(justify: false)
   let current_page = counter(page).at(here()).last()

   if current_page > 0 {
    line(length: 100%)
    v(-0.5em)
    grid(
     columns: (1fr, 1fr, 1fr),
     align(left, author),
     context {
      let final_page = counter(page).final().last()
      align(center)[#(current_page) / #(final_page)]
     },
     align(right, contact)
    )
   }
  }
 )

 // ==========================
 // = Cheatsheet information =
 // ==========================
 

 {
  set align(center)
  set text(size: 12pt, weight: "bold", lang: lang)
  title
  linebreak()
  set text(size: 10pt, weight: "regular", lang: lang)
  emph(subtitle)
 }

 
 // ========================
 // = Display Content Body =
 // ========================

 body


 // =================
 // = Display TODOs =
 // =================

 show_todo_list()
}
