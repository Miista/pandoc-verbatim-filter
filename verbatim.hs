#!/usr/bin/env runhaskell
import Text.Pandoc
import Text.Pandoc.JSON

main :: IO ()
main = toJSONFilter verbatim

verbatim :: Block -> Block
verbatim = bottomUp verbatimInline

mkVerbatim :: String -> String
mkVerbatim s = unlines ["\\begin{verbatim}", s, "\\end{verbatim}"]

verbatimInline :: Inline -> Inline
verbatimInline (Code attr@(_,[],_) code) = Span attr [RawInline (Format "latex") $ concat ["\\verb!", code, "!"]]
verbatimInline x = x
