#!/usr/bin/env runhaskell
import Text.Pandoc
import Text.Pandoc.JSON

main :: IO ()
main = toJSONFilter verbatim

verbatim :: Maybe Format -> Block -> Block
verbatim (Just f)
  | f == Format "latex" = bottomUp verbatimInline
verbatim _ = id

-- | "Protects" against "Missing $ inserted"
-- when inline code contains underscores.
--
-- The underscores are prefixed with a backslash.
protect :: String -> String
protect [] = []
protect ('_':xs) = "\\_" ++ protect xs
protect (x:xs) = x : protect xs

mkVerbatim :: String -> String
mkVerbatim s = "\\texttt{" ++ (protect s) ++ "}"

verbatimInline :: Inline -> Inline
verbatimInline (Code attr@(_,[],_) code) =
    Span attr [RawInline (Format "latex") (mkVerbatim code)]
verbatimInline x = x
