module Main where

import Control.Exception
import Data.Foldable (find)
import System.Directory (getHomeDirectory, setCurrentDirectory)
import System.Environment (getArgs)
import System.FilePath

main :: IO ()
main = do
  args <- getArgs

  let markName = unwords args
  homeDir <- getHomeDirectory

  let locationsDir = homeDir </> ".config/mrk/locations"
  markFile <- try $ readFile locationsDir :: IO (Either IOException String)

  content <- case markFile of
    Left _ -> return ""
    Right content -> return content
  let mark = find ((==) markName . takeWhile (/= ':')) $ lines content

  case mark of
    Nothing -> return ()
    Just m -> do
      let path = dropWhile (/= '/') m
      putStrLn path
