module Paths_Compiler (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/banacorn/Documents/2014 Fall/Compiler-Fall-2014/.cabal-sandbox/bin"
libdir     = "/Users/banacorn/Documents/2014 Fall/Compiler-Fall-2014/.cabal-sandbox/lib/x86_64-osx-ghc-7.8.2/Compiler-0.1.0.0"
datadir    = "/Users/banacorn/Documents/2014 Fall/Compiler-Fall-2014/.cabal-sandbox/share/x86_64-osx-ghc-7.8.2/Compiler-0.1.0.0"
libexecdir = "/Users/banacorn/Documents/2014 Fall/Compiler-Fall-2014/.cabal-sandbox/libexec"
sysconfdir = "/Users/banacorn/Documents/2014 Fall/Compiler-Fall-2014/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Compiler_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Compiler_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Compiler_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Compiler_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Compiler_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
