local multiVideo = require "plugin.multiVideo"
local json = require "json"
local widget = require "widget"
local video1 = system.pathForFile( "test.mp4" )
local video2 = system.pathForFile( "test2.mp4" )
local videoIndex = 1
local maxVideoCount = 3
multiVideo.init(system.pathForFile( "fullScreen.png" ))--setup fullscreen button
multiVideo.showView(display.contentCenterX, display.contentCenterY, {"http://videocdn.bodybuilding.com/video/mp4/62000/62792m.mp4",video1, video2})
timer.performWithDelay( 10000, function()
    multiVideo.hideFullscreenButton()
end )
timer.performWithDelay( 20000, function()
    multiVideo.showFullscreenButton()
end )
local multiVideoBackground = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, 140 )
local shouldSlide = true

local function handleSwipesForVideo(event)

  if event.xStart < event.x-150 and shouldSlide == true then
    if videoIndex ~= 1 then
        videoIndex = videoIndex-1
        multiVideo.changeVideoToIndex(videoIndex, 1)
        shouldSlide = false
        timer.performWithDelay( 1000, function ()
            shouldSlide = true
        end )
    end
  end
  if event.xStart > event.x+150 and shouldSlide == true then
    if videoIndex ~= maxVideoCount then
        videoIndex = videoIndex+1
        multiVideo.changeVideoToIndex(videoIndex, 1)
        shouldSlide = false
        timer.performWithDelay( 1000, function ()
          shouldSlide = true
        end )
    end
  end
end
multiVideoBackground.alpha = 0.01
local goToVideo = widget.newButton(
    {
        x = display.contentCenterX,
        y = display.contentCenterY+150,
        label = "Go to Video 1",
        onPress = function ()
          videoIndex = 1
          multiVideo.changeVideoToIndex(videoIndex, 0.5)
        end
    }
)
local goToVideo2 = widget.newButton(
    {
        x = display.contentCenterX,
        y = display.contentCenterY+200,
        label = "Go to Video 2",
        onPress = function ()
          videoIndex = 2
          multiVideo.changeVideoToIndex(videoIndex, 0.5)
        end
    }
)
multiVideoBackground:addEventListener("touch", handleSwipesForVideo)
