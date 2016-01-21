An h1 header
============

Paragraphs are separated by a blank line.

2nd paragraph. *Italic*, **bold**, `code`,  and ~~strike through~~. Itemized lists
look like:

  * this one
  * that one
  * the other one

Note that for blockquote the actual text content starts at 4-columns in.

> Block quotes are
> written like so.
>
> They can span multiple paragraphs,
> if you like.

Smartpants:

Markdown     | HTML                         | Result
------------ | -------------                | ------------
's           | &amp;rsquo;s                 | 's
"Quotes"     | &amp;ldquo;Quotes&amp;rdquo; | "Quotes"
`---`        | &amp;mdash;                  | ---
`--`         | &amp;ndash;                  | --
`...`        | &amp;hellip;                 | ...
`. . .`      | &amp;hellip;                 | . . .
`(c)`        | &amp;copy;                   | (c)
`(r)`        | &amp;reg;                    | (r)
`(tm)`       | &amp;trade;                  | (tm)
`3/4`        | &amp;frac34;                 | 3/4
`1/2`        | &amp;frac12;                 | 1/2
`1/4`        | &amp;frac14;                 | 1/4

An h2 header
------------

Here's a numbered list:

 1. first item
 2. second item
 3. third item

Note again how the actual text starts at 4 columns in (4 characters
from the left side). Here's a code sample:

    # Let me re-iterate ...
    for i in 1 .. 10 { do-something(i) }

As you probably guessed, indented 4 spaces. By the way, instead of
indenting the block, you can use delimited blocks, if you like:

```
define foobar() {
    print "Welcome to flavor country!";
}
```


```python
import time
# Quick, count to ten!
for i in range(10):
    # (but not *too* quick)
    time.sleep(0.5)
    print i
```

### An h3 header ###

Now a nested list:

 1. First, get these ingredients:

      * carrots
      * celery
      * lentils

 2. Boil some water.

 3. Dump everything in the pot and follow
    this algorithm:

        find wooden spoon
        uncover pot
        stir
        cover pot
        balance wooden spoon precariously on pot handle
        wait 10 minutes
        goto first step (or shut off burner when done)

    Do not bump wooden spoon or it will fall.

Notice again how text always lines up on 4-space indents (including
that last line which continues item 3 above).

Here's a link to [a website](http://foo.bar), to a [local
doc](local-doc.html), and to a [section heading in the current
doc](#an-h2-header). Here's a footnote [^1].

[^1]: Footnote text goes here.

### Tables

A simple table looks like this:

First Header | Second Header | Third Header
------------ | ------------- | ------------
Content Cell | Content Cell  | Content Cell
Content Cell | Content Cell  | Content Cell

If you wish, you can add a leading and tailing pipe to each line of the table:

| First Header | Second Header | Third Header |
| ------------ | ------------- | ------------ |
| Content Cell | Content Cell  | Content Cell |
| Content Cell | Content Cell  | Content Cell |

Specify alignment for each column by adding colons to separator lines:

First Header | Second Header | Third Header
:----------- | :-----------: | -----------:
Left         | Center        | Right
Left         | Center        | Right

***

### Images

An inline image ![Smaller icon](http://25.io/smaller/favicon.ico "Title here"), title is optional.

A ![Resize icon][2] reference style image.

[2]: http://resizesafari.com/favicon.ico "Title"
