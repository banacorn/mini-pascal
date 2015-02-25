module Compiler.Type.Free where

import Control.Applicative

data Free f a = Free (f (Free f a)) | Pure a

instance Functor f => Functor (Free f) where
    fmap f (Free as) = Free (fmap (fmap f) as)
    fmap f (Pure a)  = Pure (f a)

instance Functor f => Applicative (Free f) where
    pure = Pure
    Pure f  <*> a = fmap f a
    Free fs <*> a = Free (fmap (<*> a) fs)

instance Functor f => Monad (Free f) where
    return = Pure
    Pure a  >>= f = f a
    Free as >>= f = Free (fmap (>>= f) as)
