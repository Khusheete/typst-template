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


#import "style.typ": paper_template
#import "utils/propbox.typ": *

#show: paper_template.with(
 author: [Ferdinand Souchet],
 contact: [ferdinand.souchet\@etu.umontpellier.fr],
 title: [Example],
 subtitle: [Cool subtitle],
 lang: "fr",
)

= Hello World

#definition(title: [666])[
 The number of the devil.
]

#remk()[
 Hello World
]

#theorem()[
 Try something better.
]

#property()[
 That thing.
] <Hello>

#demonstration(property: <Hello>, title: [How does one do it ?])[
 And thus it is true.
]


== A

== B

=== a

=== b

== C


```cpp
#include <iostream>
#include <cstdlib>


void print_hello_world();


int main(void) {
 print_hello_world();
 std::cout << "This" << " line" << " is" << " a" << " really" << " long" << " line" << std::endl;
 return EXIT_SUCCESS;
}


void print_hello_world() {
 std::cout << "Hello World" << std::endl;
}
```
