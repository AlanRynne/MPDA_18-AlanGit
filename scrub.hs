module Filter where

import Text.Pandoc.JSON
import Text.Pandoc.Definition

main :: IO ()
main = toJSONFilter scrub

scrub :: Block -> Block
scrub h@(Header level (uid, cs, kvs) title)
  | level >= 3 = Header level (uid, "unnumbered" : cs, kvs) title
  | otherwise = h
scrub b = b
