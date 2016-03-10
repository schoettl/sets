{-# LANGUAGE QuasiQuotes #-}

import System.Console.Docopt
import System.Environment (getArgs)
import Data.List (group, sort, transpose)
import Control.Monad (when)

patterns :: Docopt
patterns = [docopt|generate_items

usage:
  generate_items -S [-s N] [-m N]
  generate_items -P N

options:
  -S  generate sets with N spans/matches
  -s, --spans=N
  -m, --matches=N
  -P N
      generate items that are not sets in N features;
      this means, that the "odd ball" (last item) differs in N features
      from the actual third set item.
|]

colors = "bgr"
shapes = "mst"
fills  = "dfl"

getArgOrExit = getArgOrExitWith patterns

main = do
    let allItems = [ [c, s, f] | c <- colors, s <- shapes, f <- fills ]
    let allCombinations = [ [a, b, c] | a <- allItems, b <- allItems, c <- allItems ]
    let allSets = filter isSet allCombinations
    -- printResult allSets

    args <- parseArgsOrExit patterns =<< getArgs
    when (args `isPresent` shortOption 'S') $ do
        let nS = read $ getArgWithDefault args "-1" $ longOption "spans"   :: Int
        let nM = read $ getArgWithDefault args "-1" $ longOption "matches" :: Int
        let nSpan  = if nS < 0 then const True else isNSpan nS
        let nMatch = if nM < 0 then const True else isNMatch nM
        let result = filter (\x -> nSpan x && nMatch x) allSets
        printResult result
    when (args `isPresent` shortOption 'P') $ do
        n <- fmap read $ args `getArgOrExit` shortOption 'P'
        let n' = 3 - n -- is not set in n features -> is set in n' features
        let result = filter (isSetInNFeatures n') allCombinations
        printResult result
        -- Maria's nrow(span3_noSETs):
        -- let result' = filter (isNSpan 3 . take 2) result
        -- printResult result'


isSet :: [String] -> Bool
isSet items =
    let grouped = groupFeatures items
     in all allSameOrAllDifferent grouped

isNSpan :: Int -> [String] -> Bool
isNSpan n items =
    let grouped = groupFeatures items
     in count ((==length items) . length) grouped == n

isNMatch :: Int -> [String] -> Bool
isNMatch n items =
    let grouped = groupFeatures items
     in count ((==1) . length) grouped == n

isSetInNFeatures :: Int -> [String] -> Bool
isSetInNFeatures n items =
    let grouped = groupFeatures items
     in count allSameOrAllDifferent grouped == n

count f = length . filter f

groupFeatures :: [String] -> [[String]]
groupFeatures = map (group . sort) . transpose

-- | Given a grouped list of one feature: Are all same or all different? Is it
-- a set in this feature? Is it match or span?
allSameOrAllDifferent :: [String] -> Bool
allSameOrAllDifferent xs = let n = length xs in n==1 || n==3

printResult :: [[String]] -> IO ()
printResult = mapM_ (putStrLn . unwords)

-- | Wenn man f && g als predicate verwenden will...
-- (&&&) :: (a -> Bool) -> (a -> Bool) -> a -> Bool
-- (&&&) f g x = f x && g x