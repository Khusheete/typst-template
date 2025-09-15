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


// Derivative
#let odv(func, var, order: 1) = {
  if order > 1 {
    math.frac(
      $dif^#order #func$,
      $dif #var^#order$
    )
  } else {
    math.frac(
      $dif #func$,
      $dif #var$
    )
  }
}


// Partial derivative
#let pdv(func, ..vars) = {
  let order = 0
  let bottom = for var in vars.pos() {
    if type(var) == array {
      let name = var.at(0)
      let ord = var.at(1)

      $diff #name^(#ord)$
      order += ord
    } else {
      math.diff
      var
      order += 1
    }
  }

  if order > 1 {
    math.frac(
      $diff^#order #func$,
      bottom
    )
  } else {
    math.frac(
      $diff #func$,
      bottom
    )
  }
}


// Vector operator
#let span = math.op("span", limits: true)
#let rk = math.op("rk")


// Labeled equation
#let lequ(equation, numbering: "(1)") = {
  set math.equation(numbering: numbering)
  equation
}


// Quod Erat Demonstrandum
#let qed() = align(right, math.square)


// Src math font
#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)
