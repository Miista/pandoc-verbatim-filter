# What is this?

I like to use the `listings` package when compiling with Pandoc.
Unfortunately this has a somewhat subtle unintended side effect
of not highlighting inline code blocks.

Consider the text below.

    This is some `text`.

If you compile this document with the `listings` switch on
then the word "text" is not typed in a monospaced font
even though it should be.

This filter remedies that by turning all inline code blocks
into invocations of `\verb`.

# How to call this filter

Place it somewhere on your system.
Let's say `~/.pandoc/filters`.

Then when calling `pandoc` add the following switch

~~~~
    --filter ~/.pandoc/filters/verbatim.hs
~~~~

# Limitations

This filter only works when converting to latex
and thus also PDF.

