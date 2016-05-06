# Nazareth Knot

![The Nazareth Knot][knot.png]

The Nazareth Knot is an ancient drawing in found in a church in Bethlehem (duh!). It is really a nice byzantine knot that reminds us of the very similar keltic knots. Of course I wanted to recreate it. First of all, I took a [photo of the original mosaic][2015-07-31%2016.21.02.jpg]. Then I made a [pen-and-paper sketch][2015-09-07%2021.44.28.jpg] of it to get a better intuition of the workings of this knot. And finally I created an [SVG image][knot.svg], which is what this repository is all about.

I did some calculations in Ruby and [generated the SVG using ERB code][index.rhtml]. I really enjoyed playing with Ruby's array methods like `map`, `zip`, `flatten`, `each_cons`, `each_slice` and `repeated_permutation`. For developing I wrote a tiny [script that renders the ERB into proper HTML, whenever the code changes][watch.sh] using [fswatch][fswatch]. It also displays errors on the page when something goes wrong. Happens to the best. Also I [monkey-patched Ruby's Matrix class with some 2D affine transformation-foo][helpers.rb] for all the calculations. Also, I used copies of the paths and the `stroke-dasharray` CSS property to create the interweaved strings, which is why the SVG looks great in Chrome but broken in pretty much all other SVG viewers.

Licence: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

Author: [Bernhard Häussner](http://bernhardhaeussner.de).

[knot.png]: https://raw.githubusercontent.com/bxt/Nazareth-Knot/gh-pages/knot.png
[2015-07-31%2016.21.02.jpg]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/2015-07-31%2016.21.02.jpg
[2015-09-07%2021.44.28.jpg]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/2015-09-07%2021.44.28.jpg
[knot.svg]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/knot.svg
[index.rhtml]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/index.rhtml
[watch.sh]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/watch.sh
[fswatch]: https://emcrisostomo.github.io/fswatch/
[helpers.rb]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/helpers.rb
