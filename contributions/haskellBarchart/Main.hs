
import Graphics.Rendering.Chart
import Data.Accessor

layout
  = layout1_title ^= "Patch history by user"
  $ layout1_plots ^= [ Left (plotBars bars) ]
  $ defaultLayout1 :: Layout1 Int Double

bars
  = plot_bars_titles ^= ["1","2"]
  $ plot_bars_spacing ^= BarsFixWidth 101
  $ plot_bars_style ^= BarsStacked
  $ plot_bars_values ^= [(2007,[1.0,2.0]),(2008,[1.5,7.0]),(2009,[3.0,4.0]),(2010,[3.0,4.0])]
  $ defaultPlotBars


{-
chart = layout 
  where
    values = [ ("Mexico City",19.2,e), ("Mumbai",12.9,e), ("Sydney",4.3,e), ("London",8.3,e), ("New York",8.2,e1) ]
    e = 0
    e1 = 25
    pitem (s,v,o) = defaultPieItem{pitem_value_=v,pitem_label_=s,pitem_offset_=o}

    layout = pie_title ^= "Relative Population"
           $ pie_plot ^: pie_data ^= map pitem values
           $ defaultPieLayout
-}

main = do
--    renderableToWindow (toRenderable chart) 640 480
    renderableToPNGFile (toRenderable layout) 640 480 "test.png"