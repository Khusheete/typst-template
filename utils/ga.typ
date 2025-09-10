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


// =================
// = Basis vectors =
// =================

#let e(..numbers) = {
 let numbering = ""
 for nb in numbers.pos() {
  numbering += str(nb)
 }

 $bold(e)_#numbering$
}

#let e1 = e(1)
#let e2 = e(2)
#let e3 = e(3)
#let e0 = e(0)
#let e01 = e(0, 1)
#let e02 = e(0, 2)
#let e03 = e(0, 3)
#let e23 = e(2, 3)
#let e31 = e(3, 1)
#let e12 = e(1, 2)
#let e032 = e(0, 3, 2)
#let e013 = e(0, 1, 3)
#let e021 = e(0, 2, 1)
#let e123 = e(1, 2, 3)
#let e0123 = e(0, 1, 2, 3)


// =============
// = Operators =
// =============

#let grade(a) = $lr(angle.l #a angle.r)$
#let rev(a) = $#a^dagger$ // Reverse
#let pol(a) = $#a^bot$ // Polarity
#let hodge = math.class("unary", $star$)
#let ihodge = math.class("unary", $star^(-1)$)

#let normal(a) = math.accent(a, math.hat, size: 200%)
#let mag(a) = $abs(#a)^2$ // Magnitude

#let commut = math.times

#let lcontract = math.class("binary", $floor.r$)
#let rcontract = math.class("binary", $floor.l$)


// ========
// = Sets =
// ========


#let ga(p, q, r) = $GG_(#p, #q, #r)$
#let pga = ga(3, 0, 1)
