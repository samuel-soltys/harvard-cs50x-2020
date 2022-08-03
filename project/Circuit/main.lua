Class = require 'class'

require 'Bg'
require 'Circles'
require 'Screens'
-- window resolution
WINDOW_WIDTH = 720
WINDOW_HEIGHT = 1280

-- seed RNG
math.randomseed(os.time())

-- setting start level
LEVEL = 0
WIN = 0
-- calling bg adn circles init - loading them
bg = Bg()
circles = Circles()

screens = Screens()

-- performs initialization of all objects and data needed by program
function love.load()
    music = love.audio.newSource("sounds/bensound-memories.mp3", "stream")
    click = love.audio.newSource("sounds/click.wav", "static")
    ding = love.audio.newSource("sounds/ding.wav", "static")
    completedLevel = love.audio.newSource("sounds/transitions.wav", "stream")
    simplificaFont50 = love.graphics.newFont("fonts/simplifica.ttf", 50)
    simplificaFont75 = love.graphics.newFont("fonts/simplifica.ttf", 75)
    simplificaFont100 = love.graphics.newFont("fonts/simplifica.ttf", 100)
    simplificaFont150 = love.graphics.newFont("fonts/simplifica.ttf", 150)
    robotoFont = love.graphics.newFont("fonts/roboto/Roboto-Light.ttf", 75)

    love.window.setTitle('Circuit')
    love.window.setMode( WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false
    })
    music:setLooping(true)
    music:setVolume(0.37)
    
    completedLevel:setVolume(0.4)
    click:setVolume(0.8)
    ding:setVolume(5)
    music:play()
    
end

-- called whenever a key is pressed
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

-- called every frame, with dt passed in as delta in time since last frame
function love.update(dt)
    if LEVEL >= 1 then
        if LEVEL == 10 then
            screens:update(dt)
        end
        circles:update(dt)
    else
        screens:update(dt)
    end
end

-- called each frame, used to render to the screen
function love.draw()
    -- bg
    bg:render()
    if LEVEL >= 1 and (WIN == 0 or fade == 2) then
        circles:render() 
    else
        screens:render()
    end
end

function math.lerp(a, b, t)
    return a + (b - a) * t
end

