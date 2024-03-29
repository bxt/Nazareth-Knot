# Nazareth Knot

![The Nazareth Knot][knot.png]

The Nazareth Knot is an ancient drawing in found in a church in Bethlehem (duh!). It is really a nice byzantine knot that reminds us of the very similar keltic knots. Of course I wanted to recreate it. First of all, I took a [photo of the original mosaic][2015-07-31%2016.21.02.jpg]. Then I made a [pen-and-paper sketch][2015-09-07%2021.44.28.jpg] of it to get a better intuition of the workings of this knot. And finally I created an [SVG image][knot.svg], which is what this repository is all about.

I did some calculations in Ruby and [generated the SVG using ERB code][index.rhtml]. I really enjoyed playing with Ruby's array methods like `map`, `zip`, `flatten`, `each_cons`, `each_slice` and `repeated_permutation`. For developing I wrote a tiny [script that renders the ERB into proper HTML, whenever the code changes][watch.sh] using [fswatch][fswatch]. It also displays errors on the page when something goes wrong. Happens to the best. Also I [monkey-patched Ruby's Matrix class with some 2D affine transformation-foo][helpers.rb] for all the calculations. Also, I used copies of the paths and the `stroke-dasharray` CSS property to create the interweaved strings, as you can see on [the web page][index.html].

License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

Author: [Bernhard Häussner](http://bernhardhaeussner.de).

[knot.png]: https://raw.githubusercontent.com/bxt/Nazareth-Knot/gh-pages/export/knot.png
[2015-07-31%2016.21.02.jpg]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/2015-07-31%2016.21.02.jpg
[2015-09-07%2021.44.28.jpg]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/2015-09-07%2021.44.28.jpg
[knot.svg]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/export/knot.svg
[index.rhtml]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/index.rhtml
[watch.sh]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/watch.sh
[fswatch]: https://emcrisostomo.github.io/fswatch/
[helpers.rb]: https://github.com/bxt/Nazareth-Knot/blob/gh-pages/helpers.rb
[index.html]: http://bxt.github.io/Nazareth-Knot/

# Ravello Knots

![The Ravello Switch Knot][ravello.png]
![The Ravello Round Knot][ravello_round.png]

The Ravello Knots are based on a mosaic found in a church in Ravello, Italy. The city is one of the most beautiful towns along the Amalfi Coast, mostly for its wonderful gardens. A found the knot a long time ago while [travelling to Italy][italy]. I already "harvested" this knot then, since I created a [computer graphic of the original knot][original] and later did [a drawing of a slight modification][sketchbook] to my sketchbook.

Since I wanted to continue exploring the SVG creations more I was looking for old sketches to refresh and the knot from Ravello came to my mind. I not only did a [nice SVG drawing of the old sketch][ravello.html] but took it further to create a [totally new variation][ravello_round.html] showing off the `stroke-dasharray` technique in a most spectacular way.

License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

Author: [Bernhard Häussner](http://bernhardhaeussner.de).

[ravello.png]: https://raw.githubusercontent.com/bxt/Nazareth-Knot/gh-pages/export/ravello.png
[ravello_round.png]: https://raw.githubusercontent.com/bxt/Nazareth-Knot/gh-pages/export/ravello_round.png
[italy]: http://bernhardhaeussner.de/blog/tags/Italien
[original]: http://bernhardhaeussner.de/upl/Ravello_Knot.png
[sketchbook]: http://bernhardhaeussner.de/upl/Ravello%20Switch.png
[ravello.html]: http://bxt.github.io/Nazareth-Knot/ravello.html
[ravello_round.html]: http://bxt.github.io/Nazareth-Knot/ravello_round.html

# Even More Knots

Since I already build the tools, I created even more knots. Also I started
calulating the `stroke-dasharray`s instead of just guessing them. I used some
complex trigonometric calculations but in the end it allowed me to
algorithmically create whole knots including overlaps instead of just the paths.
You should check them out:

* [Generic Knot (n=6)](http://bxt.github.io/Nazareth-Knot/more/generic.html)
* [Tri Knot](http://bxt.github.io/Nazareth-Knot/more/tri.html)
* [TriCircle Knot](http://bxt.github.io/Nazareth-Knot/more/tricircle.html)

And for fun I created even more stuff:

* [Binary circle](http://bxt.github.io/Nazareth-Knot/more/binary.html)
* [Color circle](http://bxt.github.io/Nazareth-Knot/more/colorcircle.html)
* [TriKnot](http://bxt.github.io/Nazareth-Knot/more/triknot.html)
* [Wheel](http://bxt.github.io/Nazareth-Knot/more/wheel.html)
* [TriAni](http://bxt.github.io/Nazareth-Knot/more/triani.html)
* [TriAni (orange variation)](http://bxt.github.io/Nazareth-Knot/more/triani_orange.html)
* [BernAni](http://bxt.github.io/Nazareth-Knot/more/bernani.html)
* [Office Box](http://bxt.github.io/Nazareth-Knot/more/officebox.html), created after [this box I found in an office](https://github.com/bxt/Nazareth-Knot/blob/gh-pages/2020-02-17%2018.09.42.jpg)
* [Rotating hex](http://bxt.github.io/Nazareth-Knot/more/rotatinghex.html)
* [Folded hex](http://bxt.github.io/Nazareth-Knot/more/foldedhex.html)
* [A lot of S](http://bxt.github.io/Nazareth-Knot/more/alotofs.html)
* [Shining carpet](http://bxt.github.io/Nazareth-Knot/more/shiningcarpet.html)
