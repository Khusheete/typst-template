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


// =======================
// = Package translation =
// =======================


#let _propbox_translation = (
  prop: (
    en: "Property",
    fr: "Propriété",
  ),
  def: (
    en: "Definition",
    fr: "Définition",
  ),
  theo: (
    en: "Theorem",
    fr: "Théorème",
  ),
  remk: (
    en: "Remark",
    fr: "Remarque",
  ),
  demo: (
    en: "Demonstration",
    fr: "Démonstration",
  ),
  example: (
    en: "Example",
    fr: "Exemple",
  ),
  exercice: (
    en: "Exercice",
    fr: "Exercice",
  ),
  of: (
    en: "of",
    fr: "de",
  ),
)


#let _pb_tr(key) = _propbox_translation.at(key).at(text.lang)


// =====================
// = Package Functions =
// =====================


#let propbox(
  symbol: none,
  kind: none,
  stroke: black,
  fill: white,
  title: "",
  ..body
) = {
  let counter = context counter(figure.where(kind: kind)).get().last()

  figure(
    kind: kind,
    supplement: symbol,
    align(
      left,
      block(
        width: 100%,
        stroke: stroke,
        fill: fill,
        inset: 8pt,
        radius: 5pt,
        {
          underline(
            strong[#symbol #context _pb_tr(kind) #counter:#{if title != none [ #title]}]
          )
          linebreak()
          text(..body)
        },
      )
    )
  )
}


#let exbox(
  symbol: none,
  kind: none,
  stroke: black,
  fill: white,
  title: "",
  ..body
) = {
  let counter = context counter(figure.where(kind: kind)).get().last()

  figure(
    kind: kind,
    supplement: symbol,
    align(left, block(
      stroke: (left: black, right: none, top: none, bottom: none),
      inset: 8pt,
      width: 100%,
      {
        block(
          inset: (left: 0pt, right: 0pt, top: 0pt, bottom: 2pt),
          stroke: (left: none, right: none, top: none, bottom: black),
          strong[#math.sigma #context _pb_tr(kind) #counter: #{if title != none [ #title]}]
        )
        linebreak()
        text(..body)
      },
    ))
  )
}


#let property(title: none, ..body) = propbox(
  symbol: math.Xi,
  kind: "prop",
  stroke: orange.darken(50%),
  fill: orange.lighten(60%).desaturate(25%),
  title: title,
  ..body
)


#let definition(title: none, ..body) = propbox(
  symbol: math.Delta,
  kind: "def",
  stroke: purple.darken(50%),
  fill: purple.lighten(65%).desaturate(25%),
  title: title,
  ..body
)


#let theorem(title: none, ..body) = propbox(
  symbol: math.tau,
  kind: "theo",
  stroke: blue.darken(50%),
  fill: blue.lighten(75%).desaturate(25%),
  title: title,
  ..body
)


#let remk(title: none, ..body) = propbox(
  symbol: math.rho,
  kind: "remk",
  stroke: yellow.darken(50%).desaturate(50%),
  fill: yellow.lighten(70%),
  title: title,
  ..body
)


#let demonstration(property: none, title: none, ..body) = block(
  stroke: (left: black, right: none, top: none, bottom: none),
  inset: 8pt,
  width: 100%,
  {
    block(
      inset: (left: 0pt, right: 0pt, top: 0pt, bottom: 2pt),
      stroke: (left: none, right: none, top: none, bottom: black),
      strong[#math.Gamma #context _pb_tr("demo")#{if property != none [ #context _pb_tr("of") #ref(property)]}:#{if title != none [ #title]}]
    )
    text(..body)
  },
)


#let example(title: none, ..body) = exbox(
  symbol: math.sigma,
  kind: "example",
  title: title,
  ..body
)


#let exercice(title: none, ..body) = exbox(
  symbol: math.Sigma,
  kind: "exercice",
  title: title,
  ..body
)


#let exercice1(title: none, ..body) = exbox(
  symbol: math.integral,
  kind: "exercice",
  title: title,
  ..body
)


#let exercice2(title: none, ..body) = exbox(
  symbol: math.integral.cont,
  kind: "exercice",
  title: title,
  ..body
)


#let blockbreak() = v(100%)
