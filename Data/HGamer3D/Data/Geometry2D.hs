-- This source file is part of HGamer3D
-- (A project to enable 3D game development in Haskell)
-- For the latest info, see http://www.hgamer3d.org
--
-- (c) 2014 Peter Althainz
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Rectangle.hs

-- | Type definitions for 2D geometry 
module HGamer3D.Data.Geometry2D
(
  -- * Geometry
  Point (..),
  Rectangle (..),
  rectFromPoints,
  pointsFromRect
  
) where
  
import HGamer3D.Data.Vector

-- | A point has two coordinates an x and y one
data Point = Point {
  ptX :: Int,
  ptY :: Int
  }
                      
-- | A rectangle has an a position as x and y and widht and height
data Rectangle = Rectangle {
  rectX :: Int,
  rectY :: Int,
  rectWidth :: Int,
  rectHeight :: Int } deriving (Eq, Show)

-- | derive a rectangle from upper left and lower right points
rectFromPoints :: Point -> Point -> Rectangle
rectFromPoints upperLeft lowerRight = Rectangle rx ry rw rh where
  rx = ptX upperLeft
  ry = ptY upperLeft
  rw = (ptY lowerRight) - rx
  rh = (ptY lowerRight) - ry
  
-- | get upper left and lower right point from a rect
pointsFromRect :: Rectangle -> (Point, Point)
pointsFromRect rect = (ul, lr) where
  rx = rectX rect
  ry = rectY rect
  rx' = rx + (rectWidth rect)
  ry' = ry + (rectHeight rect)
  ul = Point rx ry
  lr = Point rx' ry'
  
