{-| Charting of the historical salary data -} 

module Company.History (
  chart
) where

import Graphics.Rendering.Chart
import Graphics.Rendering.Chart.Backend.Diagrams
import Data.Default.Class
import Control.Lens
import GHC.Float
import Data.Map (empty)

-- | Generate .png file for development of median
chart :: String -> String -> [(Int,Float)] -> IO ()
chart filename title values = do
  let fileoptions = FileOptions (640,480) SVG empty
  renderableToFile fileoptions (toRenderable layout) filename
  return ()
    where
      layout
        = def
        & layout_title .~ "Development of salaries over the years"
        & layout_plots .~ [plotBars bars]
      bars
        = def
        & plot_bars_titles  .~ [title]
        & plot_bars_spacing .~ BarsFixGap 42 101
        & plot_bars_style   .~ BarsStacked
        & plot_bars_values  .~ values'
      values'
        = map (\(y,f) -> (y, [float2Double f])) values
