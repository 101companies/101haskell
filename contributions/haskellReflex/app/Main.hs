{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE RecursiveDo #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Text

import Data.List (sort)

import Reflex.Dom hiding (Dynamic, Event, Behavior)
import qualified Reflex.Dom as R
import Company

-- A lot of details, talk to me after class...

type T = SpiderTimeline Global
type Dynamic = R.Dynamic T
type Behavior = R.Behavior T
type Event = R.Event T

-- mainWidget :: (forall x. Widget x ()) -> JSM ()
-- simpleList :: ... => Dynamic t [v] -> (Dynamic t v -> m a) -> m (Dynamic t [a])

input :: Text -> Widget x (Dynamic Text)
input label = el "div" (fmap value (text label >> inputElement def))

section :: Widget x a -> Widget x a
section = el "section"

title :: Text -> Widget x ()
title x = el "h3" (text x)

info :: Dynamic Company -> Widget x ()
info c =
    section do
        title "Info"
        text "Total cost: $"
        display (total <$> c)

-- | A widget that creates a company that is defined for all points in time
--
-- Before `Hire` is ever clicked, the company is the sample value, but after
-- each click on `Hire` a person is added
hiring :: Widget x (Dynamic Company)
hiring =
    section do
        title "Hiring"
        name    <- input "Name"
        address <- input "Addr."
        salary  <- input "Salary"
        click :: Event () <- button "Hire"
        let behaviorEmployee = Employee <$> name <*> address <*> (readSalary <$> salary)
        let hireEmployee = tagPromptlyDyn behaviorEmployee click
        foldDyn addEmployee sampleCompany hireEmployee
            where
                addEmployee :: Employee -> Company -> Company
                addEmployee e (Company n es) = Company n (e:es)

                readSalary :: Text -> Salary
                readSalary = read . unpack

employeesList :: Dynamic Company -> Widget x ()
employeesList c =
    section do
        title "Employees"
        el "table" do
            el "tr" do
                el "th" (text "Name")
                el "th" (text "Address")
                el "th" (text "Salary")
            -- ROMES:TODO: Live coding (sort . )
            simpleList (employees <$> c) \dEmployee -> do
                el "tr" do
                    let dName = fmap emplName dEmployee
                    let dAddr = fmap emplAddr dEmployee
                    let dSalr = fmap emplSalr dEmployee
                    el "td" (dynText dName)
                    el "td" (dynText dAddr)
                    el "td" (dynText dSalr)
        return ()
            where
                emplName (Employee n _ _) = n
                emplAddr (Employee _ a _) = a
                emplSalr (Employee _ _ s) = "$" <> (pack . show) s

body :: Widget x ()
body = mdo

    info dynamicCompany

    dynamicCompany <- hiring

    employeesList dynamicCompany

main :: IO ()
main = mainWidgetWithCss style body

style = "body { padding: 2em; margin: auto; max-width: 50em; } h3 {margin: 0em; margin-bottom:0.5em;} section { margin-bottom: 1em; padding: 1em; border: 1px solid black; border-radius: 5px; } input { margin-left: 1em; border: 1px solid black; border-radius: 2px; padding: 0.5em;} button {padding: 0.5em 1em} td,th { padding: 0.5em; padding-right: 2em;} tr { border-bottom: 1px solid black }"

