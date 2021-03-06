{-# LANGUAGE OverloadedStrings #-}

module QuorumTools.Aws
  ( internalAwsIp
  , dockerHostIp
  , AwsClusterType (..)
  ) where

import Turtle

import QuorumTools.Types

data AwsClusterType
  = SingleRegion
  | MultiRegion

--
-- TODO: use newtypes
--
internalAwsIp :: Int -> GethId -> Ip
internalAwsIp subnets (GethId gid) =
    Ip $ format ("10.0."%d%"."%d) subnet lastOctet
  where
    idx = gid - 1 -- Zero-indexed geth id
    subnet    = 1 + (idx `mod` subnets)
    lastOctet = 101 + (idx `div` subnets)

dockerHostIp :: Ip
dockerHostIp = Ip "172.17.0.1"
