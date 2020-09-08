{-|
Module      : Language.Yatima.Term
Description : Defines expressions in the Yatima language
Copyright   : (c) Sunshine Cybernetics, 2020
License     : GPL-3
Maintainer  : contact@sunshinecybernetics.com
Stability   : experimental

This module defines `Term`, the type of expressions in the Yatima language.

-}
module Language.Yatima.Term 
  ( -- | IPFS content-identifiers
    module Language.Yatima.Uses
  , Name(..)
  , Term(..)
  , Def(..)
  ) where

import           Language.Yatima.Uses

import           Data.Text                  (Text)
import qualified Data.Text                  as T hiding (find)

-- | An abstract name used in Yatima term for parsing and printing
type Name = Text

-- | A Yatima term with names and source locations
data Term where
  -- | Local variable
  Var :: Name -> Term
  -- | A lambda
  Lam :: Name -> Maybe (Uses,Term) -> Term -> Term
  -- | An application of a function to an argument
  App :: Term -> Term -> Term
  -- | An local reference to a term in the def cache
  Ref :: Name -> Term
  -- | An inline local definition, this also requires type and usage information
  Let :: Name -> Uses -> Term -> Term -> Term -> Term
  -- | A universal quantification, extended with a "self-type"
  All :: Name -> Name -> Uses -> Term -> Term -> Term
  -- | The type of types. Note that this causes `Term` to admit paradoxes via 
  -- Gerards Paradox, and makes it unsuitable for safe theorem prooving. A
  -- future version of Yatima will likely remove @ Type : Type @
  Typ :: Term

deriving instance Show Term

-- | A type annotated definition
data Def = Def
  { _name :: Name
  , _term :: Term
  , _type :: Term
  } deriving Show