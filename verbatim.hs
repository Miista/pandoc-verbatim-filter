#!/usr/bin/env runhaskell
import Text.Pandoc
import Text.Pandoc.JSON

main :: IO ()
main = toJSONFilter verbatim

verbatim :: Maybe Format -> Block -> Block
verbatim (Just f)
  | f == Format "latex" = bottomUp verbatimInline
verbatim _ = id

mkVerbatim :: String -> String
mkVerbatim s = "\\verb!" ++ s ++ "!"

verbatimInline :: Inline -> Inline
verbatimInline (Code attr@(_,[],_) code) =
    Span attr [RawInline (Format "latex") (mkVerbatim code)]
verbatimInline x = x
